json.array!(@notifications) do |notification|
  json.extract! notification, :person_id, :talk_id, :note_type, :note_text
  json.url notification_url(notification, format: :json)
end
