# frozen_string_literal: true

class VideoSpeakersController < ApplicationController
  before_action :set_video
  before_action :set_video_speaker, only: %i[show destroy]

  def index
    @video_speakers = @video.video_speakers
  end

  def show; end

  def new
    @video_speaker = VideoSpeaker.new
  end

  def create
    @video_speaker = @video.video_speakers.new(video_speaker_params)

    if @video_speaker.save
      redirect_to video_path(@video), notice: "Спикер успешно добавлен."
    else
      redirect_to video_path(@video), error: "Спикер не может быть добавлен по какой-то причине."
    end
  end

  def destroy
    if @video_speaker.destroy
      redirect_to video_path(@video), notice: 'Спикер успешно удален.'
    else
      redirect_to video_path(@video), error: 'Спикер не может быть удален по какой-то причине'
    end
  end

  private

  def set_video_speaker
    @video_speaker = @video.video_speakers.find(params[:id])
  end

  def video_speaker_params
    params.require(:video_speaker).permit(:speaker_id)
  end

  def set_video
    @video = Video.find(params[:video_id])
  end
end
