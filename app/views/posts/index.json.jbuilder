json.array!(@posts) do |post|
  json.extract! post, :person_id, :talk_id, :post_message, :post_type
  json.url post_url(post, format: :json)
end
