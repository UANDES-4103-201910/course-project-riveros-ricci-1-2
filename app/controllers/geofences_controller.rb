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
  end

  def destroy
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
