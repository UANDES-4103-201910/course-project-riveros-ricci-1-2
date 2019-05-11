json.users @users do |user|
  json.id user.id
  json.username user.username
  json.email user.email
  json.password user.password
  json.is_admin user.is_admin
  json.is_superadmin user.is_superadmin
  json.user_status_id user.user_status_id
  json.last_access user.last_access
  json.karma user.karma
  json.created_at user.created_at
  json.updated_at user.updated_at

end

# json.extract! user, :id, :username, :email, :password, :is_admin, :is_superadmin, :status_id, :last_access, :karma, :created_at, :updated_at
# json.url user_url(user, format: :json)
