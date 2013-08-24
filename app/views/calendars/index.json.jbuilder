json.array!(@calendars) do |calendar|
  json.extract! calendar, :person_id, :name, :description, :time_point, :source, :settings
  json.url calendar_url(calendar, format: :json)
end
