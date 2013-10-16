json.array!(@messages) do |message|
  json.extract! message, :sender_id, :receiver_id, :message_type, :message_text
  json.url message_url(message, format: :json)
end
