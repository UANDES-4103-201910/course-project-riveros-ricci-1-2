class Geofence < ApplicationRecord
  has_many :geofence_vertices
  has_and_belongs_to_many :users
end
