json.array!(@socials) do |social|
  json.extract! social, :person_id, :talk_id, :social_type, :social_text
  json.url social_url(social, format: :json)
end
