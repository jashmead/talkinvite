json.array!(@talks) do |talk|
  json.extract! talk, :person_id, :summary, :description, :talk_date, :talk_time, :talk_duration, :address, :longitude, :latitude, :privacy, :talk_status
  json.url talk_url(talk, format: :json)
end
