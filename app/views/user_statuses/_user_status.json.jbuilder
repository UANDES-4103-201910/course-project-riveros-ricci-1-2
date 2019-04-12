json.extract! user_status, :id, :name, :comment, :created_at, :updated_at
json.url user_status_url(user_status, format: :json)
