json.extract! post_flag, :id, :post_id, :flagged_by_id, :comment, :created_at, :updated_at
json.url post_flag_url(post_flag, format: :json)
