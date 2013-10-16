json.array!(@maps) do |map|
  json.extract! map, :name, :description, :geometry, :settings, :history
  json.url map_url(map, format: :json)
end
