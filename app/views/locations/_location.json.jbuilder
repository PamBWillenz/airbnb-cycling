json.extract! @location, :id, :description :created_at, :updated_at
json.url location_url(location, format: :json)
