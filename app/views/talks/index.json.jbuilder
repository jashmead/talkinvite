json.array!(@talks) do |talk|
  json.extract! talk, :summary, :description, :location_id
  json.url talk_url(talk, format: :json)
end
