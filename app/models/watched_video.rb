# frozen_string_literal: true

class WatchedVideo < ApplicationRecord
  belongs_to :user
  belongs_to :video

  has_many :video_tags, through: :video
  has_many :video_languages, through: :video
  has_many :video_speakers, through: :video
  has_many :video_categories, through: :video

  scope :watched_video_exist, ->(video, user) { where(video_id: video, user_id: user.id) }

  # not used
  scope :user_preferences, lambda { |user|
    select('watched_videos.user_id, watched_videos.video_id, video_tags.tag_id, video_languages.language_id,
            video_speakers.speaker_id, video_categories.category_id')
      .left_joins(:video_tags, :video_languages, :video_speakers, :video_categories)
      .where(user_id: user.id)
  }

  paginates_per 25
end
