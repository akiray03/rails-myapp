class Feedback < ApplicationRecord
  belongs_to :user
  has_many :feedback_comments

  validates :title, length: {maximum: 100}
  validates :description, length: {maximum: 4000}
end
