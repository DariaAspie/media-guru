# frozen_string_literal: true

module Users
  class SearchQuery
    def initialize(search_params:)
      @search_params = search_params
    end

    def call
      return unless @search_params[:search].presence

      User.all.by_name(@search_params[:search])
    end
  end
end
