json.extract! training_session, :id, :user_id, :training_id, :is_leader, :created_at, :updated_at
json.url training_session_url(training_session, format: :json)
