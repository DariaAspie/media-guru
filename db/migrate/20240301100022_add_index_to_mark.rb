# frozen_string_literal: true

class AddIndexToMark < ActiveRecord::Migration[7.0]
  def change
    add_index :marks, %i[user_id video_id], unique: true
  end
end
