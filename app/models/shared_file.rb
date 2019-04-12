class SharedFile < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :file_type
end
