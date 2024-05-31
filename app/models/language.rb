# frozen_string_literal: true

class Language < ApplicationRecord
  has_many :video_languages, dependent: :destroy
  has_many :videos, through: :video_languages

  validates :language_name, presence: true
end
