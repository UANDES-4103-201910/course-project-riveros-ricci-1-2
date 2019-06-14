class PostsController < ApplicationController
  require 'will_paginate/array'
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show, :map]

  # GET /posts
  # GET /posts.json
  def index
    dumpster = Dumpster.pluck(:post_id)
    dumpster = dumpster.to_s.sub('[', '(').sub(']', ')')

    @posts = Post.where("id NOT IN #{dumpster}")
    case params[:order]
    when 'recent'
      @posts = @posts.order(created_at: :desc)
    when 'controversial'
      @posts = @posts.sort_by(&:controversy_score).reverse
    when 'top'
      @posts = @posts.sort_by(&:score).reverse
    when 'hot'
      @posts = @posts.sort_by(&:hot).reverse
    end
    @posts = @posts.paginate(page: params[:page], per_page: 8)
  end

  def following
    @posts = @current_user.follow_posts.map(&:post).paginate(page: params[:page], per_page: 8)
    render 'index'
  end

  def map
    @posts = Post.all.where('location_latitude IS NOT NULL AND location_longitude IS NOT NULL')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    authorize! :edit, @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user ||= @current_user
    main_picture = params[:post][:main_picture]
    @post.main_picture.attach(main_picture) unless main_picture.nil?
    files = params[:post][:files]
    @post.files.attach(files) unless files.nil?

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      if @current_user.admin?
        params.require(:post)
              .permit(:user_id, :description, :is_resolved, :content, :location_latitude,
                      :location_longitude, :city, :country, :is_open)
      else
        params.require(:post)
              .permit(:description, :is_resolved, :content, :location_latitude,
                      :location_longitude, :city, :country, :is_open)
      end
    end
end
