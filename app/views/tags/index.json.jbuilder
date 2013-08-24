json.array!(@tags) do |tag|
  json.extract! tag, :tagable_type, :tabable_id, :tag_type, :tag
  json.url tag_url(tag, format: :json)
end
