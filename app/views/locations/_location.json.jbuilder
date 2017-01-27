json.extract! @location, :id, :title, :description, :address_1, :address_2, :city, :state, :postcode, :bike_type, :guests, :member_id :created_at, :updated_at
json.url location_url(location, format: :json)
