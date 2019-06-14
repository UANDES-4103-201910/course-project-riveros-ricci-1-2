class PostFlag < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :post_id, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, scope: [:post_id], message: 'You can\'t flag a post twice!'

  after_create :send_to_dumpsters
  after_create :send_to_blacklist

  def send_to_dumpsters
    if PostFlag.where(post_id: self.post_id).count > 1
      Dumpster.create!(post_id: self.post_id, user: self.user)
    end
  end


  def send_to_blacklist
    all_posts = PostFlag.where("created_at >= ?", Date.today - 7).distinct.pluck(:post_id)
    count = 0
    count2 = []
    all_user_posts = Post.where(user_id: 16).pluck(:id)
    all_user_posts.map do |post|
      if all_posts.include?(post)
        count += 1
        snitch = PostFlag.where(post_id: post).pluck(:user_id)
        snitch.map do |user|
          if !count2.include?(user)
            count2 << user
          end
        end
      end
    end


    if count >= 2 and count2.size >= 3
      Blacklist.create!(user: self.post.user, start_date: Date.today, end_date: Date.today + 7)
    end
  end
end
