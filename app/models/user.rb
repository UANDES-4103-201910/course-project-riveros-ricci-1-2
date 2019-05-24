class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 1 }, format: { with: /\A[a-zA-Z0-9]*\z/i }

  before_validation :load_defaults, on: :create

  def load_defaults
    self.user_status_id ||= 1
    self.karma = 0
    self.is_admin ||= false
    self.is_superadmin ||= false
  end

end
