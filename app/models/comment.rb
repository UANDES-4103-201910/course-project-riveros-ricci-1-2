class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :post_id, presence: true
  validates :user_id, presence: true

  def anchor
    "c#{self.id}"
  end
end
