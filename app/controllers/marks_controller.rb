# frozen_string_literal: true

class MarksController < ApplicationController
  before_action :set_video
  before_action :set_mark, only: %i[edit show update destroy]

  def index
    @marks = @video.marks
    @mark = Mark.new
  end

  def show; end

  def new
    @mark = Mark.new
  end

  def edit; end

  def create
    @mark = @video.marks.new(mark_params)

    @mark.user = current_user if current_user

    if @mark.save
      redirect_to video_path(@video), notice: 'Оценка успешно добавлена.'
    else
      redirect_to video_path(@video), status: :unprocessable_entity,
                                      notice: 'Оценка не может быть добавлена по какой-то причине.'
    end
  end

  def update
    if @mark.update(mark_params)
      redirect_to video_path(@video), notice: 'Оценка успешно обновлен'
    else
      redirect_to video_path(@video), status: :unprocessable_entity,
                                      notice: 'Оценка не может быть обновлена по какой-то причине.'
    end
  end

  def destroy
    if @mark.destroy
      redirect_to video_mark_path, notice: 'Оценка успешно удалена.'
    else
      redirect_to video_mark_path, error: 'Оценка не может быть удалена по какой-то причине.'
    end
  end

  private

  def set_video
    @video = Video.find(params[:video_id])
  end

  def set_mark
    @mark = @video.marks.find(params[:id])
  end

  def mark_params
    params.require(:mark).permit(:digit)
  end
end
