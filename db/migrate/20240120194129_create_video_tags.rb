# frozen_string_literal: true

class CreateVideoTags < ActiveRecord::Migration[7.0]
  def change
    create_table :video_tags do |t|
      t.belongs_to :video, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
