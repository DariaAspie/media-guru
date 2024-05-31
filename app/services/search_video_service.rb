# frozen_string_literal: true

require './app/queries/videos/search_query'

class SearchVideoService
  def initialize(search_params:)
    @search_params = search_params
  end

  def call
    if @search_params.present?
      Videos::SearchQuery.new(search_params: @search_params).call
    else
      Video.all
    end
  end

  def call_recommendations(current_user)
    if @search_params.present?
      Videos::SearchQuery.new(search_params: @search_params).call_recommendations(current_user)
    else
      Video.sorted_by_user_preferences(current_user)
    end
  end

  def call_favorites(current_user)
    if @search_params.present?
      Videos::SearchQuery.new(search_params: @search_params).call_favorites(current_user)
    else
      current_user.favorites
    end
  end
end
