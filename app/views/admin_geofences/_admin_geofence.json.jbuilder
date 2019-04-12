json.extract! admin_geofence, :id, :user_id, :latitude, :longitude, :created_at, :updated_at
json.url admin_geofence_url(admin_geofence, format: :json)
