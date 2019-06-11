class Post < ApplicationRecord
  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :follow_posts, dependent: :destroy
  has_many :user_shareds, dependent: :destroy
  has_many :shared_files, dependent: :destroy
  has_many :post_flags, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one :dumpster
  has_one_attached :main_picture
  has_many_attached :files

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

  def score
    votes.sum(:value)
  end

  def upvotes
    votes.select{ |vote| vote.value >= 1 }.count
  end

  def downvotes
    votes.select{ |vote| vote.value <= -1 }.count
  end
end
