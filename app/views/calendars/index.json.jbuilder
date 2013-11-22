json.array!(@calendars) do |calendar|
  json.extract! calendar, :person_id, :talk_id, :name, :description, :scale
  json.url calendar_url(calendar, format: :json)
end
