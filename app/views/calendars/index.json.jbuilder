json.array!(@calendars) do |calendar|
  json.extract! calendar, :name, :description, :chronometry, :settings, :history
  json.url calendar_url(calendar, format: :json)
end
