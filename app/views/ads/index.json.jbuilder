json.array!(@ads) do |ad|
  json.extract! ad, :name, :description, :internal_flag, :content, :source, :strategy, :stats
  json.url ad_url(ad, format: :json)
end
