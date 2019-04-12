class PostFlag < ApplicationRecord
  belongs_to :post
  belongs_to :flagged_by
end
