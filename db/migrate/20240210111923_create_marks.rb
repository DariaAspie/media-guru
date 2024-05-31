# frozen_string_literal: true

class CreateMarks < ActiveRecord::Migration[7.0]
  def change
    create_table :marks do |t|
      t.references :video, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :digit

      t.timestamps
    end
  end
end
