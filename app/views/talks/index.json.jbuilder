json.array!(@talks) do |talk|
  json.extract! talk, :person_id, :summary, :description, :talk_date, :talk_time, :talk_duration, :address, :longitude, :latitude, :talk_status
  json.url talk_url(talk, format: :json)
end
