json.array!(@maps) do |map|
  json.extract! map, :person_id, :name, :description, :location_id, :source, :settings
  json.url map_url(map, format: :json)
end
