# frozen_string_literal: true

class VideoLanguagesController < ApplicationController
  before_action :set_video
  before_action :set_video_language, only: %i[show destroy]

  def index
    @video_languages = @video.video_languages
  end

  def show; end

  def new
    @video_language = VideoLanguage.new
  end

  def create
    @video_language = @video.video_languages.new(video_language_params)

    if @video_language.save
      redirect_to video_path(@video), notice: 'Язык успешно добавлена.'
    else
      flash.now[:alert] = 'Язык не может быть добавлена по какой-то причине.'
      render :new
    end
  end

  def destroy
    if @video_language.destroy
      redirect_to video_path(@video), notice: 'Язык успешно удалена.'
    else
      flash.now[:alert] = 'Язык не может быть удалена по какой-то причине.'
      render :show
    end
  end

  private

  def set_video_language
    @video_language = @video.video_languages.find(params[:id])
  end

  def video_language_params
    params.require(:video_language).permit(:language)
  end

  def set_video
    @video = Video.find(params[:video_id])
  end
end
