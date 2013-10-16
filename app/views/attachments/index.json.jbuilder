json.array!(@attachments) do |attachment|
  json.extract! attachment, :name, :description, :attachment_type, :attachable_type, :attachable_id, :file_path
  json.url attachment_url(attachment, format: :json)
end
