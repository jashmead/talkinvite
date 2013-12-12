json.array!(@partners) do |partner|
  json.extract! partner, :talk_id, :person_id, :rsvp_status, :partner_type
  json.url partner_url(partner, format: :json)
end
