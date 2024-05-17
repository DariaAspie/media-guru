# frozen_string_literal: true

class Speaker < ApplicationRecord
  has_many :video_speakers, dependent: :destroy
  has_many :videos, through: :video_speakers

  validates :speaker_fio, presence: true
end
