# frozen_string_literal: true

class WatchedVideosController < ApplicationController
  before_action :set_watched_video, only: %i[edit show update destroy]

  def index
    @watched_videos = current_user.watched_videos.page(params[:page]).per(params[:per_page])
    @watched_video = watched_video.new
  end

  def show; end

  def new
    @watched_video = watched_video.new
  end

  def destroy
    if @watched_video.destroy
      redirect_to video_watched_video_path, notice: 'Оценка успешно удалена.'
    else
      redirect_to video_watched_video_path, error: 'Оценка не может быть удалена по какой-то причине.'
    end
  end

  private

  def set_watched_video
    @watched_video = current_user.watched_videos.find(params[:id])
  end
end
