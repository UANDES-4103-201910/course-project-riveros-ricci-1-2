class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates_uniqueness_of :user_id, scope: %i[post_id value], message: 'You can\'t up/down vote again.'
  after_commit :normalize_vote

  def normalize_vote
    self.value = self.value > 0 ? 1 : self.value < 0 ? -1 : 0
  end

end
