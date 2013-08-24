json.array!(@tweets) do |tweet|
  json.extract! tweet, :person_id, :screen_name, :content, :location_id
  json.url tweet_url(tweet, format: :json)
end
