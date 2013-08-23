json.array!(@people) do |person|
  json.extract! person, :name, :email, :about_me, :twitter_handle, :settings
  json.url person_url(person, format: :json)
end
