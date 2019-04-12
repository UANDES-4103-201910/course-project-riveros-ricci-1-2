json.extract! shared_file, :id, :user_id, :post_id, :file_type_id, :path, :created_at, :updated_at
json.url shared_file_url(shared_file, format: :json)
