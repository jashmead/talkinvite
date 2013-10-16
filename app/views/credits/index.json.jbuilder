json.array!(@credits) do |credit|
  json.extract! credit, :worthy_one, :service_supplied
  json.url credit_url(credit, format: :json)
end
