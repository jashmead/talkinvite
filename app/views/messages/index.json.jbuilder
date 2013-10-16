json.array!(@messages) do |message|
  json.extract! message, :message_type, :sender_id, :receiver_id, :message_text
  json.url message_url(message, format: :json)
end
