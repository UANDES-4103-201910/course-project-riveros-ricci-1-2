json.extract! user_shared, :id, :user_id, :post_id, :created_at, :updated_at
json.url user_shared_url(user_shared, format: :json)
