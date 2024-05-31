# frozen_string_literal: true

require './app/services/search_video_service'

class FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[edit show update destroy]

  def index
    Rails.logger.debug "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+++-+\nsearch params"
    Rails.logger.debug search_params
    @favorites = SearchVideoService.new(
      search_params:
    ).call_favorites(current_user).order('created_at DESC').page(params[:page]).per(params[:per_page])
    @favorite = Favorite.new
  end

  def show; end

  def new
    @favorite = Favorite.new
  end

  def destroy
    if @favorite.destroy
      redirect_to video_favorite_path, notice: 'Оценка успешно удалена.'
    else
      redirect_to video_favorite_path, error: 'Оценка не может быть удалена по какой-то причине.'
    end
  end

  private

  def set_favorite
    @favorite = current_user.favorites.find(params[:id])
  end

  def search_params
    params.permit(:search, :tag_id, :language_id, :speaker_id, :category_id, :commit)
  end
end
