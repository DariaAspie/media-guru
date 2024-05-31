# frozen_string_literal: true

class CreateVideoCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :video_categories do |t|
      t.belongs_to :video, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
