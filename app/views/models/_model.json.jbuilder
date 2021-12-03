json.extract! model, :id, :User, :username, :email, :created_at, :updated_at
json.url model_url(model, format: :json)
