# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :video_categories, dependent: :destroy
  has_many :videos, through: :video_categories

  validates :category_name, presence: true
end
