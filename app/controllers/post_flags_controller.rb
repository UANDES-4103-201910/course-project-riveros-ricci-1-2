class PostFlagsController < ApplicationController
  before_action :set_post_flag, only: [:show, :edit, :update, :destroy]

  # GET /post_flags
  # GET /post_flags.json
  def index
    @post_flags = PostFlag.all
  end

  # GET /post_flags/1
  # GET /post_flags/1.json
  def show
  end

  # GET /post_flags/new
  def new
    @post_flag = PostFlag.new
  end

  # GET /post_flags/1/edit
  def edit
  end

  # POST /post_flags
  # POST /post_flags.json
  def create
    @post_flag = PostFlag.new(post_flag_params)
    @post_flag.user ||= @current_user

    respond_to do |format|
      if @post_flag.save
        format.html { redirect_to root_path, notice: 'Post flagged successfully created.' }
        format.json { render :show, status: :created, location: @post_flag }
      else
        format.html { render :new }
        format.json { render json: @post_flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_flags/1
  # PATCH/PUT /post_flags/1.json
  def update
    respond_to do |format|
      if @post_flag.update(post_flag_params)
        format.html { redirect_to @post_flag, notice: 'Post flag was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_flag }
      else
        format.html { render :edit }
        format.json { render json: @post_flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_flags/1
  # DELETE /post_flags/1.json
  def destroy
    @post_flag.destroy
    respond_to do |format|
      format.html { redirect_to post_flags_url, notice: 'Post flag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_flag
      @post_flag = PostFlag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_flag_params
      if @current_user.admin?
        params.require(:post_flag).permit(:post_id, :user_id, :comment)
      else
        params.require(:post_flag).permit(:post_id, :comment)
      end
    end
end
