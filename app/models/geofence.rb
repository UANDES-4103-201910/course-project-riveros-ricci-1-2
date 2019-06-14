class Geofence < ApplicationRecord
  include GeoRuby::SimpleFeatures

  has_many :geofence_vertices, dependent: :destroy
  has_and_belongs_to_many :users

  attr_accessor :points

  def build_polygon
    points = []
    self.geofence_vertices.map { |v| points << [v.latitude, v.longitude] }
    Polygon.from_coordinates([points], 4326)
  end

  def contains_location?(lat, lng)
    return false if lat.nil? || lng.nil?
    point = Point.from_x_y(lat, lng)
    build_polygon.contains_point?(point)
  end
end
