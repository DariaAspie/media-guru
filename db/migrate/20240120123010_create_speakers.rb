# frozen_string_literal: true

class CreateSpeakers < ActiveRecord::Migration[7.0]
  def change
    create_table :speakers do |t|
      t.string :speaker_fio, null: false

      t.timestamps
    end
  end
end
