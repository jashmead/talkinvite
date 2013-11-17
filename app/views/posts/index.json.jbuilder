json.array!(@posts) do |post|
  json.extract! post, :sender_id, :receiver_id, :post_type, :post_text
  json.url post_url(post, format: :json)
end
