json.extract! user, :id, :emp_id, :email, :username, :role_id, :deleted_at, :created_at, :updated_at
json.url user_url(user, format: :json)
