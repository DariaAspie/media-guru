# frozen_string_literal: true

class LanguagesController < ApplicationController
  before_action :set_language, only: %i[show destroy]

  def index
    @languages = Language.all
  end

  def show; end

  def new
    @language = Language.new
  end

  def create
    @language = Language.create!(language_params)
    if @language.save!
      redirect_to videos_path, notice: 'Язык успешно добавлен.'
    else
      redirect_to videos_path, error: 'Язык не может быть добавлен по какой-то причине.'
    end
  end

  def destroy
    if @language.destroy
      redirect_to path(@video), notice: 'Язык успешно удален.'
    else
      flash.now[:alert] = 'Язык не может быть удален по какой-то причине.'
      render :show
    end
  end

  private

  def set_language
    @language = Language.find(params[:id])
  end

  def language_params
    params.require(:language).permit(:language_name)
  end
end
