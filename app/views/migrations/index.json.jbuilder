json.array!(@migrations) do |migration|
  json.extract! migration, :notification, :person_id, :talk_id, :notification_type, :notification_text
  json.url migration_url(migration, format: :json)
end
