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
end
