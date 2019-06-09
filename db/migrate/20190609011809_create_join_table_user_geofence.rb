class CreateJoinTableUserGeofence < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :geofences do |t|
      # t.index [:user_id, :geofence_id]
      # t.index [:geofence_id, :user_id]
    end
  end
end
