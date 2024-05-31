# frozen_string_literal: true

require './app/services/search_video_service'

class VideosController < ApplicationController
  before_action :set_video,
                only: %i[edit show update destroy add_to_watched delete_from_watched add_to_favorites delete_from_favorites
                         delete_from_videos_favorites]
  before_action :set_category_videos, only: :popularity_report
  before_action :set_speaker_videos, only: :popularity_report
  before_action :set_language_videos, only: :popularity_report
  before_action :set_videos_report, only: :popularity_report

  def index
    @videos = SearchVideoService.new(
      search_params:
    ).call.order('created_at DESC').page(params[:page]).per(params[:per_page])
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
    @favorite = current_user.favorites.new
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
    @watched_video = current_user.watched_videos.new
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
    @recommendations = SearchVideoService.new(
      search_params:
    ).call_recommendations(current_user).order('created_at DESC').page(params[:page]).per(params[:per_page])
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
      SELECT categories.category_name, COUNT(watched_videos.id) AS views_count
      FROM categories
      LEFT JOIN video_categories ON categories.id = video_categories.category_id
      LEFT JOIN videos ON video_categories.video_id = videos.id
      LEFT JOIN watched_videos ON videos.id = watched_videos.video_id
      GROUP BY categories.category_name
      ORDER BY views_count DESC
    ")

    @category_videos = videos_by_category.each_with_object({}) do |row, hash|
      category_name = row['category_name']
      views_count = row['views_count']

      hash[category_name] = views_count
    end
  end

  def set_speaker_videos
    videos_by_speaker = ActiveRecord::Base.connection.execute("
      SELECT speakers.speaker_fio, COUNT(watched_videos.id) AS views_count
      FROM speakers
      LEFT JOIN video_speakers ON speakers.id = video_speakers.speaker_id
      LEFT JOIN videos ON video_speakers.video_id = videos.id
      LEFT JOIN watched_videos ON videos.id = watched_videos.video_id
      GROUP BY speakers.speaker_fio
      ORDER BY views_count DESC
    ")

    @speaker_videos = videos_by_speaker.each_with_object({}) do |row, hash|
      speaker_fio = row['speaker_fio']
      views_count = row['views_count']

      hash[speaker_fio] = views_count
    end
  end

  def set_language_videos
    videos_by_language = ActiveRecord::Base.connection.execute("
      SELECT languages.language_name, COUNT(watched_videos.id) AS views_count
      FROM languages
      LEFT JOIN video_languages ON languages.id = video_languages.language_id
      LEFT JOIN videos ON video_languages.video_id = videos.id
      LEFT JOIN watched_videos ON videos.id = watched_videos.video_id
      GROUP BY languages.language_name
      ORDER BY views_count DESC
    ")

    @language_videos = videos_by_language.each_with_object({}) do |row, hash|
      language_name = row['language_name']
      views_count = row['views_count']

      hash[language_name] = views_count
    end
  end

  def set_videos_report
    videos_by_day = ActiveRecord::Base.connection.execute("
      SELECT DATE(watched_videos.created_at) AS view_date, COUNT(watched_videos.id) AS views_count
      FROM watched_videos
      GROUP BY view_date
      ORDER BY views_count DESC
    ")

    @daily_views = videos_by_day.each_with_object({}) do |row, hash|
      view_date = row['view_date']
      views_count = row['views_count']

      hash[view_date] = views_count
    end
  end
end
