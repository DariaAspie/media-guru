# frozen_string_literal: true

class CreateVideoLanguages < ActiveRecord::Migration[7.0]
  def change
    create_table :video_languages do |t|
      t.belongs_to :video, null: false, foreign_key: true
      t.belongs_to :language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
