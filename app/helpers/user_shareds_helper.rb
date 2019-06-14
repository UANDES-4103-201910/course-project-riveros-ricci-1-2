module UserSharedsHelper
  def shared_user_post(user_id, post_id)
    UserShared.where("user_id = #{user_id} AND post_id = #{post_id}").pluck(:id)[0]
  end
end
