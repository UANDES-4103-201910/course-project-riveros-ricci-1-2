class AdminGeofence < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
