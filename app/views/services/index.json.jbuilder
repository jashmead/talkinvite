json.array!(@services) do |service|
  json.extract! service, :person_id, :service_type, :service_notes
  json.url service_url(service, format: :json)
end
