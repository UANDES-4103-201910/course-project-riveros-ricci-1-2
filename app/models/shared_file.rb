class SharedFile < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :file_type

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :file_type_id, presence: true
  validates :path, presence: true
end
