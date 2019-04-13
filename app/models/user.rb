class User < ApplicationRecord
  belongs_to :user_status

  has_many :votes
  has_many :posts
  # The user follows another user is a more complex association
  has_many :active_follow_users, class_name: "FollowUser", foreign_key: "follower_user_id", dependent: :destroy
  has_many :followed_users, through: :active_follow_users
  has_many :passive_follow_users, class_name: "FollowUser", foreign_key: "followed_user_id", dependent: :destroy
  has_many :follower_users, through: :passive_follow_users
  has_many :follow_posts
  has_many :user_shareds
  has_many :shared_files
  has_many :post_flags
  has_many :comments
  has_many :admin_geofences
  has_one :user_profile

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
