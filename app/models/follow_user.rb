class FollowUser < ApplicationRecord
  belongs_to :user
  belongs_to :followed_user
end
