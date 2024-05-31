# frozen_string_literal: true

module Videos
  class SearchQuery
    def initialize(search_params:)
      @search_params = search_params
    end

    def call
      if @search_params[:search].presence
        Video.all.by_name(@search_params[:search])
      else
        filters.reduce(Video.all) { |videos, filter| send(filter, videos) }
      end
    end

    def call_recommendations(current_user)
      if @search_params[:search].presence
        Video.sorted_by_user_preferences(current_user).by_name(@search_params[:search])
      else
        filters.reduce(Video.sorted_by_user_preferences(current_user)) { |videos, filter| send(filter, videos) }
      end
    end

    def call_favorites(current_user)
      if @search_params[:search].presence
        current_user.favorites.by_name(@search_params[:search])
      else
        filters.reduce(current_user.favorites) { |videos, filter| send(filter, videos) }
      end
    end

    private

    def filters
      %i[filter_tag filter_language filter_speaker filter_category]
    end

    def filter_tag(videos)
      @search_params[:tag_id].presence ? videos.by_tag(@search_params[:tag_id]) : videos
    end

    def filter_language(videos)
      @search_params[:language_id].presence ? videos.by_language(@search_params[:language_id]) : videos
    end

    def filter_speaker(videos)
      @search_params[:speaker_id].presence ? videos.by_speaker(@search_params[:speaker_id]) : videos
    end

    def filter_category(videos)
      @search_params[:category_id].presence ? videos.by_category(@search_params[:category_id]) : videos
    end
  end
end
