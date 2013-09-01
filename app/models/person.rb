# People
# 
# == Fields
# 1.  name -- string, doesn't have to be unique (so long as email is!), but is mandatory
# 1.  email -- mandatory, validated 
# 1.  description -- text, optional
# 1.  about_me -- text, user supplied, for display to others
# 1.  screen_name -- twitter screen name, mandatory, but defaults to 'talkinvite'
# 1.  settings -- text, internal, used for user preferences, optional
# 1.  person_type -- string.  One of 'anon', 'reg', 'sub', 'admin', 'talkinvite'.  
# <em>Not 'type'</em>, which will cause rails to spin on its head three times widdershins & then croak
# 1.  remember_token -- sent to user as part of a cookie, then used to find him/her
# 
# == Possible additional fields
# 1.  twitter_id -- this is stable, unlike the twitter screen name which can change
# 1.  current_location_id
# 1.  home_location_id
# 1.  other fields as in twitter api
# 
# == Relationships
# 1. attachments -- child
# 1. calendars -- child
# 1. maps -- child
# 1. posts -- child
# 1. talks -- child
#
# == Possible Relationships
# 1. locations -- child, of creator
# 1. tags -- child, of creator
# 1. tweets -- child, of creator

class Person < ActiveRecord::Base
  before_save { self.email = email.downcase; self.person_type = person_type.downcase }
  # why :create_remember_token rather than { self.create_remember_token }?
  # before_save { self.create_remember_token }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 80 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, 
    presence: true, 
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: true

  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # validates_format_of :person_type, :with => /\A(anon|sub|reg|admin|site)\z/
  validates_inclusion_of :person_type, 
    :in => [ 'anon', 'sub', 'reg', 'admin', 'site' ],
    :message => "Invalid table name"

  has_many :posts
  has_many :tags, as: :tagable
  has_many :attachments, as: :attachable

  private

    def create_remember_token
      # create token
      # have to use 'self', otherwise we would get a *local* variable called remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
