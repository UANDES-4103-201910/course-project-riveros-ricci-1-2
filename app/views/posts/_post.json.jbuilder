json.extract! post, :id, :user_id, :description, :is_resolved, :content, :location_latitude, :location_longitude, :city, :country, :is_open, :created_at, :updated_at
json.url post_url(post, format: :json)
