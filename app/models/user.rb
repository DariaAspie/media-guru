# frozen_string_literal: true

class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :marks
  has_many :favorites
  has_many :watched_videos
  has_many :user_activities, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable

  enum role: { user: 0, admin: 1 }

  after_initialize :set_default_role, if: :new_record?

  validates :username, presence: true
  validates :email, presence: true, format: { with: /^[^@\s]+@[^@\s]+\.[^@\s]+$/, multiline: true }
  validates :password, presence: true, length: { within: 6..20 }

  def set_default_role
    self.role ||= :user
  end

  paginates_per 25
end
