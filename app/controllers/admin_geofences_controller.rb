class AdminGeofencesController < ApplicationController
  before_action :set_admin_geofence, only: [:show, :edit, :update, :destroy]

  # GET /admin_geofences
  # GET /admin_geofences.json
  def index
    @admin_geofences = AdminGeofence.all
  end

  # GET /admin_geofences/1
  # GET /admin_geofences/1.json
  def show
  end

  # GET /admin_geofences/new
  def new
    @admin_geofence = AdminGeofence.new
  end

  # GET /admin_geofences/1/edit
  def edit
  end

  # POST /admin_geofences
  # POST /admin_geofences.json
  def create
    geo = geofence_create(geofence_params)
    @admin_geofence = AdminGeofence.create(geo)
    # TODO: do this better

    respond_to do |format|
      if @admin_geofence
        format.html { redirect_to root_path, notice: 'Admin geofence was successfully created.' }
        format.json { render :show, status: :created, location: @admin_geofence }
      else
        format.html { render :new }
        format.json { render json: @admin_geofence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_geofences/1
  # PATCH/PUT /admin_geofences/1.json
  def update
    respond_to do |format|
      if @admin_geofence.update(admin_geofence_params)
        format.html { redirect_to @admin_geofence, notice: 'Admin geofence was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_geofence }
      else
        format.html { render :edit }
        format.json { render json: @admin_geofence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_geofences/1
  # DELETE /admin_geofences/1.json
  def destroy
    @admin_geofence.destroy
    respond_to do |format|
      format.html { redirect_to admin_geofences_url, notice: 'Admin geofence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_geofence
      @admin_geofence = AdminGeofence.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def geofence_params
      params.require(:geofence).permit(:user_id, :point_array)
    end

    def geofence_create(geofence)
      user_id = geofence[:user_id]
      points_txt = geofence[:point_array]
      output = []
      point = Hash.new
      points_txt.gsub(/LatLng\((-?[0-9]+\.?[0-9]*),\ (-?[0-9]+\.?[0-9]*)\)/) do
        point[:user_id] = user_id
        point[:latitude] = $1.to_f
        point[:longitude] = $2.to_f
        output << point.clone
      end
      output
    end
end
