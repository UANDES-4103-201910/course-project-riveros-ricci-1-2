class GeofencesController < ApplicationController
  before_action :set_geofence, only: %i[show edit update destroy]

  def index
    @geofences = Geofence.all
  end

  def show
  end

  def new
    @geofence = Geofence.new
  end

  def edit
  end

  def create
    @geofence = Geofence.new(description: params[:geofence][:description])
    @geofence.geofence_vertices << build_vertices(params[:geofence][:points])
    params[:geofence][:user_ids].map do |u_id| # assign geofence to selected users
      u = User.find_by_id(u_id)
      u.geofences << @geofence unless u.nil?
    end

    respond_to do |format|
      if @geofence.save
        format.html { redirect_to root_path, notice: 'Admin geofence was successfully created.' }
        format.json { render :show, status: :created, location: @geofence }
      else
        format.html { render :new }
        format.json { render json: @geofence.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @geofence.assign_attributes({ description: params[:geofence][:description] })
    unless params[:geofence][:points] == ''
      # TODO: delete old vertices. Maybe in a cleanup task?
      @geofence.geofence_vertices.replace(build_vertices(params[:geofence][:points]))
    end
    @geofence.users.clear
    params[:geofence][:user_ids].map do |u_id| # assign geofence to selected users
      u = User.find_by_id(u_id)
      u.geofences << @geofence unless u.nil?
    end

    respond_to do |format|
      if @geofence.save
        format.html { redirect_to geofences_path, notice: 'Geofence was successfully updated.' }
        format.json { render :show, status: :ok, location: @geofence }
      else
        format.html { render :edit }
        format.json { render json: @geofence.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @geofence.destroy
    respond_to do |format|
      format.html { redirect_to geofences_path, notice: 'Geofence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_geofence
      @geofence = Geofence.find(params[:id])
    end

    def geofence_params
      params.require(:geofence).permit(:description, :user_ids, :points)
    end

    def build_vertices(points)
      points_txt = points
      output = []
      points_txt.gsub(/LatLng\((-?[0-9]+\.?[0-9]*),\ (-?[0-9]+\.?[0-9]*)\)/) do
        output << GeofenceVertex.new(latitude: $1.to_f, longitude: $2.to_f)
      end
      output
    end
end
