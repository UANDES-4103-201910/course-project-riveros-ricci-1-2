class UserProfile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  validates :user_id, presence: true
end
