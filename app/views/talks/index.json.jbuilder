json.array!(@talks) do |talk|
  json.extract! talk, :summary, :description
  json.url talk_url(talk, format: :json)
end
