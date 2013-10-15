json.array!(@venues) do |venue|
  json.extract! venue, :person_id, :name, :description, :longitude, :latitude, :venue_type
  json.url venue_url(venue, format: :json)
end
