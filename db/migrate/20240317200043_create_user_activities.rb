# frozen_string_literal: true

class CreateUserActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :user_activities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :action, null: false
      t.datetime :login_time
      t.datetime :logout_time
      t.string :session_id

      t.timestamps
    end
  end
end
