# People
# 
# == Fields
# 1.  name -- string, doesn't have to be unique (so long as email is!), but is mandatory
# 1.  email -- mandatory, validated 
# 1.  description -- text, optional
# 1.  admin -- boolean, administrator, includes talkinvite
# 1.  sub -- boolean, subscriber, does not include anonymous
# 1.  remember_token -- sent to user as part of a cookie, then used to find him/her
# 
# == Relationships
# people<-talks
# TBD:
# 1. add active_flag boolean to people, use to deactivate when the user has killed, in case there is other data we need to keep associated with this

class Person < ActiveRecord::Base
  has_many :talks, dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 80 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, 
    presence: true, 
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: true

  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # there is a problem with find_by(:remember_token, remember_token); not clear why...
  def find_by_remember_token( encrypted_remember_token ) 
  ##  logger.debug("Person.find_by_remember_token: encrypted_remember_token: %{encrypted_remember_token}") #DDT

    person = Person.where(remember_token: encrypted_remember_token)
  ##  logger.debug("Person.find_by_remember_token:  person: #{person}") #DDT
    person #to make sure person is returned
  end

  # class method, hence the 'Person.'
  def Person.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Person.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)  # 'to_s' is to make sure we can handle nil tokens
  end

  def feed
    # could use 'talks' to get all of the associated talks!
    Talk.where("person_id = ?", id)
  end

  private

    def create_remember_token
      # create token
      # have to use 'self', otherwise we would get a *local* variable called remember_token
      self.remember_token = Person.encrypt(Person.new_remember_token)
    ##  logger.debug("Person.create_remember_token: self.remember_token: #{self.remember_token}")#DDT
      self.remember_token #DDT
    end

end
