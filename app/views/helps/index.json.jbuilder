json.array!(@helps) do |help|
  json.extract! help, :name, :title, :description, :help_type
  json.url help_url(help, format: :json)
end
