# People
# 
# == Fields
# 1.  name -- string, unique, mandatory
# 1.  email -- mandatory, validated 
# 1.  description -- text, optional
# 1.  about_me -- text, user supplied
# 1.  twitter_handler -- twitter screen name
# 1.  settings -- text, internal, used for user preferences
# 1.  person_type -- string.  One of 'anonymous', 'registered', 'subscriber', 'admin', 'talkinvite'.  
# <em>Not 'type'</em>, which will cause rails to spin on its head three times widdershins & then croak
# 
# == Possible additional fields
# 1.  twitter_id -- this is stable, unlike the twitter screen name which can change
# 1.  current_location_id
# 1.  home_location_id
# 1.  other fields as in twitter api
# 
class Person < ActiveRecord::Base
  has_many :posts
  has_many :tags, as: :tagable
  has_many :attachments, as: :attachable
  has_and_belongs_to_many :messaging,
    :join_table => 'messages',
    :foreign_key => 'from_person_id',
    :association_foreign_key => 'to_person_id',
    :class_name => 'Person'
end
