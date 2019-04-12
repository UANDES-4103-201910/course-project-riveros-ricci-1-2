class SharedFilesController < ApplicationController
  before_action :set_shared_file, only: [:show, :edit, :update, :destroy]

  # GET /shared_files
  # GET /shared_files.json
  def index
    @shared_files = SharedFile.all
  end

  # GET /shared_files/1
  # GET /shared_files/1.json
  def show
  end

  # GET /shared_files/new
  def new
    @shared_file = SharedFile.new
  end

  # GET /shared_files/1/edit
  def edit
  end

  # POST /shared_files
  # POST /shared_files.json
  def create
    @shared_file = SharedFile.new(shared_file_params)

    respond_to do |format|
      if @shared_file.save
        format.html { redirect_to @shared_file, notice: 'Shared file was successfully created.' }
        format.json { render :show, status: :created, location: @shared_file }
      else
        format.html { render :new }
        format.json { render json: @shared_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shared_files/1
  # PATCH/PUT /shared_files/1.json
  def update
    respond_to do |format|
      if @shared_file.update(shared_file_params)
        format.html { redirect_to @shared_file, notice: 'Shared file was successfully updated.' }
        format.json { render :show, status: :ok, location: @shared_file }
      else
        format.html { render :edit }
        format.json { render json: @shared_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shared_files/1
  # DELETE /shared_files/1.json
  def destroy
    @shared_file.destroy
    respond_to do |format|
      format.html { redirect_to shared_files_url, notice: 'Shared file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shared_file
      @shared_file = SharedFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shared_file_params
      params.require(:shared_file).permit(:user_id, :post_id, :file_type_id, :path)
    end
end
