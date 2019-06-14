class SearchController < ApplicationController
  def index
    @search = params['search']['q']
    if @search
      @users = User.where("username LIKE '%#{@search}%'").or(User.where("email LIKE '%#{@search}%'"))
      @posts = Post.where("description LIKE '%#{@search}%'").or(Post.where("content LIKE '%#{@search}%'"))
    end
  end
end