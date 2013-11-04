json.array!(@helps) do |help|
  json.extract! help, :name, :description
  json.url help_url(help, format: :json)
end
