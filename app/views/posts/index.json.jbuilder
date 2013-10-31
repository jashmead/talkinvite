json.array!(@posts) do |post|
  json.extract! post, :person_id, :talk_id, :service_type, :service_notes, :post_type, :post_message
  json.url post_url(post, format: :json)
end
