# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :video_tags, dependent: :destroy
  has_many :videos, through: :video_tags

  validates :tag_name, presence: true
end
