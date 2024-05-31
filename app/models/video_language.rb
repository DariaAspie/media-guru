# frozen_string_literal: true

class VideoLanguage < ApplicationRecord
  belongs_to :video
  belongs_to :language
end
