json.array!(@attachments) do |attachment|
  json.extract! attachment, :person_id, :name, :description, :file_type, :pathname, :attachable_type, :attachable_id
  json.url attachment_url(attachment, format: :json)
end
