json.array!(@credits) do |credit|
  json.extract! credit, :name, :description, :url
  json.url credit_url(credit, format: :json)
end
