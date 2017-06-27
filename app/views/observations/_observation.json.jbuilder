json.extract! observation, :id, :classroom_id, :specialist_id, :principal_id, :comments, :created_at, :updated_at
json.url observation_url(observation, format: :json)
