# frozen_string_literal: true

class CreateAddRatingToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :rating, :integer
  end
end
