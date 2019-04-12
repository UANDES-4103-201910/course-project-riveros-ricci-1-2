json.extract! file_type, :id, :name, :image_path, :created_at, :updated_at
json.url file_type_url(file_type, format: :json)
