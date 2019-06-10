class PostFlag < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :post_id, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, scope: [:post_id], message: 'You can\'t flag a post twice!'

  after_create :send_to_dumpsters

  def send_to_dumpsters
    if PostFlag.where(post_id: self.post_id).count > 1
      Dumpster.create!(post_id: self.post_id, user: self.user)
    end
  end
end
