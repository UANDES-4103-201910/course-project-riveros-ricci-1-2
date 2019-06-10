class PostFlag < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :post_id, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, scope: [:post_id], message: 'You can\'t flag a post twice!'
end
