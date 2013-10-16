json.array!(@tags) do |tag|
  json.extract! tag, :tag_type, :tagable_id
  json.url tag_url(tag, format: :json)
end
