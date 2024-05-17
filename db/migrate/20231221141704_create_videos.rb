# frozen_string_literal: true

class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :video_name, null: false
      t.text :video_description, null: false
      t.string :video_url
      t.string :picture_url

      t.timestamps
    end
  end
end
