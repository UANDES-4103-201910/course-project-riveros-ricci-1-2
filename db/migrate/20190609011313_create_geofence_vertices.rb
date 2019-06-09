class CreateGeofenceVertices < ActiveRecord::Migration[5.2]
  def change
    create_table :geofence_vertices do |t|
      t.references :geofence, foreign_key: true
      t.decimal :latitude, precision: 8, scale: 6
      t.decimal :longitude, precision: 9, scale: 6

      t.timestamps
    end
  end
end
