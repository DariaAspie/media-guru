# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :video

  scope :favorite_exist, ->(video, user) { where(video_id: video, user_id: user.id) }

  scope :by_name, ->(name) { joins(:video).where('videos.video_name LIKE ?', "%#{name}%") }
  scope :by_tag, ->(tag_id) { joins(video: :video_tags).where(video_tags: { tag_id: }) }
  scope :by_language, ->(language_id) { joins(video: :video_languages).where(video_languages: { language_id: }) }
  scope :by_speaker, ->(speaker_id) { joins(video: :video_speakers).where(video_speakers: { speaker_id: }) }
  scope :by_category, ->(category_id) { joins(video: :video_categories).where(video_categories: { category_id: }) }

  paginates_per 25
end
