# People
# 
# == Fields
# 1.  name -- string, doesn't have to be unique (so long as email is!), but is mandatory
# 1.  email -- mandatory, validated 
# 1.  description -- text, optional
# 1.  admin -- boolean, administrator, includes talkinvite
# 1.  sub -- boolean, subscriber, does not include anonymous, not clear if we need this...
# 1.  remember_token -- sent to user as part of a cookie, then used to find him/her
# 1.  password, password_confirmation, password_digest
# 
# == Children
# 1. Comments
# 1. Members
# 1. Messages -- from sender & from receiver
# 1. Posts
# 1. Talks -- creator

# == Fields contemplated
# 1. active_flag -- use to deactivate when the user has killed, in case there is other data we need to keep associated with this

# Person spotted as complex by codeclimate 10/29/13, complexity 31
class Person < ActiveRecord::Base

  ## include Searchy

  ## this line *creates* the attribute/method of Person called 'talks'
  has_many :talks, inverse_of: :person, dependent: :destroy
  ## we are starting with the relationships that point 'to' the current person record

  has_many :sent_messages, inverse_of: :person, foreign_key: "sender_id", class_name: "Message", dependent: :destroy
  has_many :receivers, inverse_of: :person, through: :sent_messages, source: :receivers, dependent: :destroy
  has_many :received_messages, inverse_of: :person, foreign_key: "receiver_id", class_name: "Message", dependent: :destroy
  has_many :senders, inverse_of: :person, through: :received_messages, source: :sender

  has_many :members, inverse_of: :person, dependent: :destroy
  has_many :memberships, inverse_of: :person, through: :members, source: :talks

  has_many :comments, inverse_of: :person, dependent: :destroy
  has_many :posts, inverse_of: :person, dependent: :destroy

  before_save { self.email = email.downcase }

  before_create :create_remember_token

  ## the '->' denotes a proc or lambda, scheduled for lazy evaluation
  default_scope -> { order('people.created_at desc') }

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

  # tried 'anonymous' in the app/helpers, got whined at...
  def self.anonymous 
    anonymous = self.find_by_name('anonymous')
    if ! anonymous || anonymous.size == 0
      # logger.debug("MM: Person.anonymous: creating anonymous record")
      Person.create!( name: 'anonymous', email: 'anonymous@talkinvite.com', 
        password: 'scrofulous-nonsense', password_confirmation: 'scrofulous-nonsense')
      anonymous = self.find_by_name('anonymous')
    end
    ## logger.debug("MM: Person.anonymous: #{anonymous}")
    anonymous
  end

  private

    def add_default_service
      # put in a single record for the 'talkinvite' service!
      # use after save trap & also the service.rb model file
    end

    def create_remember_token
      # create token
      # have to use 'self', otherwise we would get a *local* variable called remember_token
      self.remember_token = Person.encrypt(Person.new_remember_token)
      ##  logger.debug("Person.create_remember_token: self.remember_token: #{self.remember_token}")#DDT
      self.remember_token #DDT
    end

end
