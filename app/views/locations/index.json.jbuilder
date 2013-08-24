json.array!(@locations) do |location|
  json.extract! location, :name, :description, :longitude, :latitude, :address
  json.url location_url(location, format: :json)
end
