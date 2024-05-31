# frozen_string_literal: true

class VideoSpeaker < ApplicationRecord
  belongs_to :video
  belongs_to :speaker
end
