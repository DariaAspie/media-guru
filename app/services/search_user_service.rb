# frozen_string_literal: true

require './app/queries/users/search_query'

class SearchUserService
  def initialize(search_params:)
    @search_params = search_params
  end

  def call
    if @search_params.present?
      Users::SearchQuery.new(search_params: @search_params).call
    else
      User.all
    end
  end
end
