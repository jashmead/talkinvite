json.array!(@posts) do |post|
  json.extract! post, :person_id, :talk_id, :post_type, :comment
  json.url post_url(post, format: :json)
end
