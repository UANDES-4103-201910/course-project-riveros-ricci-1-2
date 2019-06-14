class UserSharedsController < ApplicationController
  before_action :set_user_shared, only: [:show, :edit, :update, :destroy]

  # GET /user_shareds
  # GET /user_shareds.json
  def index
    @user_shareds = UserShared.all
  end

  # GET /user_shareds/1
  # GET /user_shareds/1.json
  def show
  end

  # GET /user_shareds/new
  def new
    @user_shared = UserShared.new
  end

  # GET /user_shareds/1/edit
  def edit
  end

  # POST /user_shareds
  # POST /user_shareds.json
  def create
    @user_shared = UserShared.new(user_shared_params)

    respond_to do |format|
      if @user_shared.save
        format.html { redirect_to '', notice: 'Post was successfully shared.' }
        format.json { render :show, status: :created, location: @user_shared }
      else
        format.html { render :new }
        format.json { render json: @user_shared.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_shareds/1
  # PATCH/PUT /user_shareds/1.json
  def update
    respond_to do |format|
      if @user_shared.update(user_shared_params)
        format.html { redirect_to '', notice: 'Post was successfully shared.' }
        format.json { render :show, status: :ok, location: @user_shared }
      else
        format.html { render :edit }
        format.json { render json: @user_shared.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_shareds/1
  # DELETE /user_shareds/1.json
  def destroy
    @user_shared.destroy
    respond_to do |format|
      format.html { redirect_to '', notice: 'Post was successfully unshared.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_shared
      @user_shared = UserShared.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_shared_params
      params.require(:user_shared).permit(:user_id, :post_id)
    end
end
