# frozen_string_literal: true

class VideoTagsController < ApplicationController
  before_action :set_video
  before_action :set_video_tag, only: %i[show destroy]

  def index
    @video_tags = @video.video_tags
  end

  def show; end

  def new
    @video_tag = VideoTag.new
  end

  def create
    @video_tag = @video.video_tags.new(video_tag_params)

    if @video_tag.save
      redirect_to video_path(@video), notice: "Тэг успешно добавлен."
    else
      redirect_to video_path(@video), error: "Тэг не может быть добавлен по какой-то причине."
    end
  end

  def destroy
    if @video_tag.destroy
      redirect_to video_path(@video), notice: 'Тэг успешно удален.'
    else
      redirect_to video_path(@video), error: 'Тэг не может быть удален по какой-то причине'
    end
  end

  private

  def set_video_tag
    @video_tag = @video.video_tags.find(params[:id])
  end

  def video_tag_params
    params.require(:video_tag).permit(:tag_id)
  end

  def set_video
    @video = Video.find(params[:video_id])
  end
end
