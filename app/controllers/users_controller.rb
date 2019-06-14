class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:new]

  # GET /users
  # GET /users.json
  def index
    # TODO: How to do this the rails way?
    @users = User.all
    case params[:filter]
    when 'non_admin'
      @users = @users.where('is_admin == 0')
    when 'admins'
      @users = @users.where.not('is_admin == 0')
    else
      @users
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def new_admin
    @user = User.new
  end

  def create_admin
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:success] = 'User created successfully. Now you can login!'
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/1/edit
  def edit
    # authorize! :edit, @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:success] = 'User created successfully. Now you can login!'
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    avatar = params[:user][:user_profile_attributes][:avatar]
    @user.profile.avatar.attach(avatar) unless avatar.nil?
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      # TODO: Fix correctly this ugly patch
      if params[:id] == 'sign_out'
        sign_out current_user
        redirect_to root_path
        return
      end
      @user = User.find_by_id(params[:id]) || @current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if current_user.is_superadmin?
        params.require(:user)
            .permit(:username, :email, :password, :is_admin, :is_superadmin,
                    :user_status_id, :karma, user_profile_attributes: [:id, :name, :bio])
      elsif current_user.admin?
        params.require(:user)
              .permit(:username, :email, :password, :is_admin,
                      :user_status_id, :karma, user_profile_attributes: [:id, :name, :bio])
      elsif current_user
        params.require(:user).permit(:username, :email, :password, user_profile_attributes: [:id, :name, :bio])
      else
        params.require(:user).permit(:username, :email, :password)
      end
    end
end
