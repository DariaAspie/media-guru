# frozen_string_literal: true

class AddAwsKeysToVideo < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :key, :string, unique: true
    add_index :videos, :key
    add_column :videos, :low_res_key, :string, unique: true
    add_index :videos, :low_res_key
  end
end
