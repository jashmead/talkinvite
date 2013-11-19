# People
# 
# == Fields
# 1.  name -- string, doesn't have to be unique (so long as email is!), but is mandatory
# 1.  email -- mandatory, validated 
# 1.  admin -- boolean, administrator, includes talkinvite
# 1.  sub -- boolean, subscriber, does not include anonymous, not clear if we need this...
# 1.  remember_token -- sent to user as part of a cookie, then used to find him/her
# 1.  password, password_confirmation, password_digest
# 1.  description -- text, optional
# 
# == Children
# 1. Comments
# 1. Members
# 1. Messages -- from sender & from receiver
# 1. Posts
# 1. Talks -- creator

# == Fields contemplated
# 1. active_flag -- use to deactivate when the user has killed, in case there is other data we need to keep associated with this
# 1. current_talk_id -- store that id in the database
# 1. url
# 1. photo
# 1. preferred start page (currently defaulting to sitemap)

class Person < ActiveRecord::Base

  ## this line *creates* the attribute/method of Person called 'talks'
  has_many :talks, inverse_of: :person, dependent: :destroy

  has_many :sent_messages, inverse_of: :person, foreign_key: "sender_id", class_name: "Message", dependent: :destroy
  has_many :receivers, inverse_of: :person, through: :sent_messages, source: :receivers, dependent: :destroy
  has_many :received_messages, inverse_of: :person, foreign_key: "receiver_id", class_name: "Message", dependent: :destroy
  has_many :senders, inverse_of: :person, through: :received_messages, source: :sender

  has_many :members, inverse_of: :person, dependent: :destroy
  has_many :memberships, inverse_of: :person, through: :members, source: :talks

  has_many :posts, inverse_of: :person, dependent: :destroy

  has_many :comments, inverse_of: :person, dependent: :destroy

  has_many :services, inverse_of: :person, dependent: :destroy

  before_save do
    # TBD:  make the name lowercase & space-free? -- would rather not, tho would let us route to /people/anonymous/talks...
    self.email = email.downcase
  end

  before_create :create_remember_token

  after_save :create_talkinvite_service

  ## the '->' denotes a proc or lambda, scheduled for lazy evaluation
  default_scope -> { order('people.created_at desc') }

  validates :name, presence: true, length: { maximum: 80 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, 
    presence: true, 
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: true

  # TBD:  replace validates password & confirmation with a validate block, called on new account & from reset forms, but not from settings
  #   -- or, use update attribute or related to do the save
  #   -- or, add in an unless { controller.action_name === 'settings' }
  #   -- or, use 'with_options'
  has_secure_password
  logger.debug(__FILE__ + ": @action_name: #{@action_name}, self: #{self.inspect}")
  # TBD: we want to validate password on new account & change password but not on settings
  #   -- how?
  # if false 
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  # end

  # TBD: there is a problem with find_by(:remember_token, remember_token); why?
  def find_by_remember_token( encrypted_remember_token ) 
    ##  logger.debug("Person.find_by_remember_token: encrypted_remember_token: %{encrypted_remember_token}") #DDT
    person = Person.where(remember_token: encrypted_remember_token)
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
    begin 
      # logger.debug("Person.anonymous")
      self.find_by_name!('anonymous')
    end
  end

  # TBD:  add in create of default service?
  def self.force!(name, email, password, options = {})
    # logger.debug("Person.force!: #{name}, #{email}, #{password}, #{options.inspect}")
    Person.find_by_name( name ) or
      Person.create!(
        name: name,
        email: email,
        password: password,
        password_confirmation: password, 
        admin: options['admin'] || false,
        sub: options['sub'] || false
      )
  end

  private

    def create_remember_token
      # have to use 'self', otherwise we would get a *local* variable called remember_token
      self.remember_token = Person.encrypt(Person.new_remember_token)
    end

    # make sure that every person has at least the 'talkinvite' service
    def create_talkinvite_service
      # logger.debug("Person.create_talkinvite_service: self: #{self.inspect}")

      if self.id?
        # logger.debug("Person.create_talkinvite_service: self.id: #{self.id.inspect}")
        @services = Service.where('person_id = ? and service_type = ?', self.id, 'talkinvite')
        if ! @services || @services.size == 0
          Service.create!( person_id: self.id, service_type: 'talkinvite' )
        end
      end

    end

end
