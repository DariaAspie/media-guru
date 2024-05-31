# frozen_string_literal: true

class Mark < ApplicationRecord
  belongs_to :video
  belongs_to :user

  validates :digit, presence: true
  validates :digit, inclusion: { in: 1..5, message: "Значение должно быть от 1 до 5." }
end
