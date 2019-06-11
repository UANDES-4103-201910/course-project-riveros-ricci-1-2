class WelcomeController < ApplicationController
  def index
    @posts = Post.all.limit(5)
  end

  def post
    # TODO: move to posts controller
  end

  def tos

  end

  def aup

  end

  def login
    # TODO: move to a sessions controller
  end
end
