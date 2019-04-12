json.extract! user, :id, :username, :email, :password, :is_admin, :is_superadmin, :status_id, :last_access, :karma, :created_at, :updated_at
json.url user_url(user, format: :json)
