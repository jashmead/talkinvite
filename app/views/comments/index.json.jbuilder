json.array!(@comments) do |comment|
  json.extract! comment, :person_id, :talk_id, :comment_text
  json.url comment_url(comment, format: :json)
end
