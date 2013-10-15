json.array!(@members) do |member|
  json.extract! member, :talk_id, :person_id, :rsvp_status, :member_type
  json.url member_url(member, format: :json)
end
