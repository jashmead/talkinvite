json.array!(@talks) do |talk|
  json.extract! talk, :person_id, :summary, :description, :when_desc, :start_dt, :end_dt, :where_desc, :longitude, :latitude, :who_desc, :talk_status, :posted_dt
  json.url talk_url(talk, format: :json)
end
