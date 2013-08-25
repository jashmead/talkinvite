# People
# 
# == Fields
# 1.  name -- string, doesn't have to be unique (so long as email is!), but is mandatory
# 1.  email -- mandatory, validated 
# 1.  description -- text, optional
# 1.  about_me -- text, user supplied, for display to others
# 1.  twitter_handler -- twitter screen name, mandatory, but defaults to 'talkinvite'
# 1.  settings -- text, internal, used for user preferences, optional
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
  validates :name, presence: true, length: { maximum: 80 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, 
    presence: true, 
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: true

  has_many :posts
  has_many :tags, as: :tagable
  has_many :attachments, as: :attachable

  before_save { self.email = email.downcase }
end
