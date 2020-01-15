class User < ApplicationRecord
  has_many :feedbacks

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ROLE_CHOICES = %w(customer support)

  has_secure_password

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false },
            on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :role, presence: true, inclusion: ROLE_CHOICES

  def customer?
    role == "customer"
  end

  def support?
    role == "support"
  end
end
