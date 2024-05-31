# frozen_string_literal: true

class CreateVideoSpeakers < ActiveRecord::Migration[7.0]
  def change
    create_table :video_speakers do |t|
      t.belongs_to :video, null: false, foreign_key: true
      t.belongs_to :speaker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
