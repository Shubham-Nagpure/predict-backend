json.extract! contest, :id, :title, :name, :contest_type, :match_id, :status, :description, :start_time, :created_at, :updated_at
json.url contest_url(contest, format: :json)
