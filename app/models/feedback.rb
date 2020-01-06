class Feedback < ApplicationRecord
  validates :title, length: {maximum: 100}
  validates :description, length: {maximum: 4000}
end
