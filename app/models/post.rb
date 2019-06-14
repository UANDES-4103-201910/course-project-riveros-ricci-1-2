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
    votes.select do |vote|
      if vote.value
        vote.value >= 1
      end
    end.count
  end

  def downvotes
    votes.select do |vote|
      if vote.value
        vote.value <= -1
      end
    end.count
  end

  def hot
    (order + sign * epoch_seconds / 45_000).round(7)
  end

  def controversy_score
    return 0 if upvotes <= 0 || downvotes <= 0
    magnitude ** balance
  end

  def magnitude
    upvotes + downvotes
  end

  def order
    Math.log([1, self.score.abs].max,10)
  end

  def balance
    (upvotes > downvotes ) ? downvotes.to_f / upvotes : upvotes.to_f / downvotes
  end

  def sign_from(score)
    return 0 if score == 0
    return 1 if score > 0
    -1
  end

  def sign
    sign_from self.score
  end

  def epoch_seconds
    self.created_at.to_i - 1134028003
  end
end
