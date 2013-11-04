json.array!(@credits) do |credit|
  json.extract! credit, :name, :description
  json.url credit_url(credit, format: :json)
end
