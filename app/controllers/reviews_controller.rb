# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_video
  before_action :set_review, only: %i[edit show update destroy]

  def index
    @reviews = @video.reviews
    @review = Review.new
  end

  def show; end

  def new
    @review = Review.new
  end

  def edit; end

  def create
    @review = @video.reviews.new(review_params)

    @review.user = current_user if current_user

    if @review.save
      redirect_to video_path(@video), notice: 'Рецензия успешно добавлена.'
    else
      render :new, status: :unprocessable_entity, error: 'Рецензия не может быть добавлена по какой-то причине.'
    end
  end

  def update
    if @review.update(review_params)
      redirect_to video_path(@video), notice: 'Рецензия успешно обновлен'
    else
      render :edit, status: :unprocessable_entity, error: 'Рецензия не может быть обновлена по какой-то причине.'
    end
  end

  def destroy
    if @review.destroy
      redirect_to video_review_path, notice: 'Рецензия успешно удалена.'
    else
      redirect_to video_review_path, error: 'Рецензия не может быть удалена по какой-то причине'
    end
  end

  private

  def set_video
    @video = Video.find(params[:video_id])
  end

  def set_review
    @review = @video.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:text)
  end
end
