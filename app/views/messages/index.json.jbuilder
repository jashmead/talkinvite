json.array!(@messages) do |message|
  json.extract! message, :from_person_id, :to_person_id, :talk_id, :message_type, :content
  json.url message_url(message, format: :json)
end
