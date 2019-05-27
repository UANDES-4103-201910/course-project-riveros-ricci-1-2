class Post < ApplicationRecord
  belongs_to :user

  has_many :votes
  has_many :follow_posts
  has_many :user_shareds
  has_many :shared_files
  has_many :post_flags
  has_many :comments

  validates :user_id, presence: true
  validates :description, presence: true

  before_validation :load_defaults, on: :create
  after_create :creator_upvote


  def load_defaults
    self.is_resolved ||= false
    self.is_open ||= true
  end

  def creator_upvote
    Vote.create(
      user_id: user_id,
      post_id: id,
      value: 1
    )
  end
end
