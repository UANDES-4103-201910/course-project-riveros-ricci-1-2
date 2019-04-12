class Dumpster < ApplicationRecord
  belongs_to :post
  belongs_to :creator
end
