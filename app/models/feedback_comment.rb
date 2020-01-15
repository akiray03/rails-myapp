class FeedbackComment < ApplicationRecord
  belongs_to :feedback
  belongs_to :user

  validates :body, presence: true, length: { maximum: 60000 }
end
