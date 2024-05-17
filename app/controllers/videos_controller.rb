# frozen_string_literal: true

require './app/services/search_video_service.rb'

class VideosController < ApplicationController
  before_action :set_video, only: %i[edit show update destroy add_to_watched delete_from_watched add_to_favorites delete_from_favorites delete_from_videos_favorites]
  before_action :set_category_videos, only: :popularity_report
  before_action :set_speaker_videos, only: :popularity_report
  before_action :set_language_videos, only: :popularity_report

  def index
    @videos = SearchVideoService.new(
      search_params:
      ).call.order(:video_name).page(params[:page]).per(params[:per_page])
  end

  def show
    @reviews = @video.reviews
    @review = Review.new
    @mark = @video.marks.new
  end

  def new
    @video = Video.new
  end

  def edit; end

  def create
    @video = Video.new(video_params)

    if @video.save
      redirect_to videos_path, notice: 'Видео успешно добавлено.'
    else
      render :new, status: :unprocessable_entity, error: 'Видео не может быть добавлено по какой-то причине.'
    end
  end

  def update
    if @video.update(video_params)
      redirect_to videos_path(@video), notice: 'Видео успешно обновлен.'
    else
      render :edit, status: :unprocessable_entity, error: 'Видео не может быть обновлено по какой-то причине.'
    end
  end

  def destroy
    if @video.destroy
      redirect_to videos_path, notice: 'Видео успешно удалено.'
    else
      redirect_to videos_path, error: 'Видео не может быть удалено по какой-то причине'
    end
  end

  def add_to_favorites
    @favorite = current_user.favorites.new()
    @favorite.video_id = @video.id

    if @favorite.save
      redirect_to videos_path, notice: 'Видео успешно добавлено в избранные.'
    else
      redirect_to videos_path, notice: 'Видео не может быть добавлено в избранные по какойто причине.'
    end
  end

  def delete_from_videos_favorites
    if deleting_favorite(@video)
      redirect_to videos_path, notice: 'Видео успешно удалено из избранных.'
    else
      redirect_to videos_path, notice: 'Видео не может быть удалено из избранных по какойто причине.'
    end
  end

  def delete_from_favorites
    if deleting_favorite(@video)
      redirect_to favorites_path, notice: 'Видео успешно удалено из избранных.'
    else
      redirect_to favorites_path, notice: 'Видео не может быть удалено из избранных по какойто причине.'
    end
  end

  def add_to_watched
    @watched_video = current_user.watched_videos.new()
    @watched_video.video_id = @video.id

    if @watched_video.save
      redirect_to video_path(@video), notice: 'Видео успешно добавлено в просмотренные.'
    else
      redirect_to video_path(@video), notice: 'Видео не может быть добавлено в просмотренные по какойто причине.'
    end
  end

  def delete_from_watched
    if deleting_watched_video(@video)
      redirect_to video_path(@video), notice: 'Видео успешно удалено из просмотренных.'
    else
      redirect_to video_path(@video), notice: 'Видео не может быть удалено из просмотренных по какойто причине.'
    end
  end

  def popularity_report
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'popularity_report', template: 'videos/popularity_report', encoding: 'utf8'
      end
    end
  end

  def count_report
    count_of_videos = ActiveRecord::Base.connection.execute("
    SELECT categories.category_name, COUNT(video_categories.video_id) AS count
    FROM categories
    LEFT JOIN video_categories ON categories.id = video_categories.category_id
    GROUP BY categories.category_name
    ORDER BY count DESC
    ")

    @videos_count = {}
    count_of_videos.each do |row|
      category_name = row['category_name']
      video_count = row['count']

      @videos_count[category_name] ||= []
      @videos_count[category_name] << video_count
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'count_report', template: 'videos/count_report', encoding: 'utf8'
      end
    end
  end

  def recommendations
    @recommendations = Video.sorted_by_user_preferences(current_user).page(params[:page]).per(params[:per_page])
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:video_name, :video_description, :picture_url, :video_url)
  end

  def deleting_watched_video(current_video)
    WatchedVideo.watched_video_exist(current_video.id, current_user).each do |watched_video|
      return false unless watched_video.delete
    end
  end

  def deleting_favorite(current_video)
    Favorite.favorite_exist(current_video.id, current_user).each do |favorite|
      return false unless favorite.delete
    end
  end

  def search_params
    params.permit(:search, :tag_id, :language_id, :speaker_id, :category_id, :commit)
  end

  def set_category_videos
    videos_by_category = ActiveRecord::Base.connection.execute("
      SELECT category_name, video_name, views_count
      FROM (
          SELECT categories.category_name, videos.video_name, COUNT(watched_videos.id) AS views_count,
                ROW_NUMBER() OVER (PARTITION BY categories.id ORDER BY COUNT(watched_videos.id) DESC) AS rn
          FROM categories
          CROSS JOIN videos
          LEFT JOIN video_categories ON categories.id = video_categories.category_id
          LEFT JOIN watched_videos ON videos.id = watched_videos.video_id
          GROUP BY categories.id, videos.id
      ) AS ranked_videos
      WHERE rn <= 5
      ORDER BY category_name, views_count DESC
    ")

    @category_videos = {}
    videos_by_category.each do |row|
      category_name = row['category_name']
      video_name = row['video_name']

      @category_videos[category_name] ||= []
      @category_videos[category_name] << video_name
    end
  end

  def set_speaker_videos
    videos_by_speaker = ActiveRecord::Base.connection.execute("
      SELECT speaker_fio, video_name, views_count
      FROM (
          SELECT speakers.speaker_fio, videos.video_name, COUNT(watched_videos.id) AS views_count,
                ROW_NUMBER() OVER (PARTITION BY speakers.id ORDER BY COUNT(watched_videos.id) DESC) AS rn
          FROM speakers
          CROSS JOIN videos
          LEFT JOIN video_speakers ON speakers.id = video_speakers.speaker_id
          LEFT JOIN watched_videos ON videos.id = watched_videos.video_id
          GROUP BY speakers.id, videos.id
      ) AS ranked_videos
      WHERE rn <= 5
      ORDER BY speaker_fio, views_count DESC
    ")

    @speaker_videos = {}
    videos_by_speaker.each do |row|
      speaker_fio = row['speaker_fio']
      video_name = row['video_name']

      @speaker_videos[speaker_fio] ||= []
      @speaker_videos[speaker_fio] << video_name
    end
  end

  def set_language_videos
    videos_by_language = ActiveRecord::Base.connection.execute("
      SELECT language_name, video_name, views_count
      FROM (
          SELECT languages.language_name, videos.video_name, COUNT(watched_videos.id) AS views_count,
                ROW_NUMBER() OVER (PARTITION BY languages.id ORDER BY COUNT(watched_videos.id) DESC) AS rn
          FROM languages
          CROSS JOIN videos
          LEFT JOIN video_languages ON languages.id = video_languages.language_id
          LEFT JOIN watched_videos ON videos.id = watched_videos.video_id
          GROUP BY languages.id, videos.id
      ) AS ranked_videos
      WHERE rn <= 5
      ORDER BY language_name, views_count DESC
    ")

    @language_videos = {}
    videos_by_language.each do |row|
      language_name = row['language_name']
      video_name = row['video_name']

      @language_videos[language_name] ||= []
      @language_videos[language_name] << video_name
    end
  end
end
