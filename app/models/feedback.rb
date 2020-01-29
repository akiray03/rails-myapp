class Feedback < ApplicationRecord
  belongs_to :user
  has_many :feedback_comments

  PRIORITY_CHOICES = %w(high middle low)
  STATUS_CHOICES = %w(new designing developing released wontfix)

  validates :title, length: {maximum: 100}
  validates :description, length: {maximum: 4000}
  validates :priority, allow_blank: true, inclusion: PRIORITY_CHOICES
  validates :status, allow_blank: true, inclusion: STATUS_CHOICES
end
