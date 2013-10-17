# People
# 
# == Fields
# 1.  name -- string, doesn't have to be unique (so long as email is!), but is mandatory
# 1.  email -- mandatory, validated 
# 1.  description -- text, optional
# 1.  admin -- boolean, administrator, includes talkinvite
# 1.  sub -- boolean, subscriber, does not include anonymous
# 1.  remember_token -- sent to user as part of a cookie, then used to find him/her
# 1.  password, password_confirmation, password_digest
# 
# == Children
# 1. Relationships
# 1. Members
# 1. Comments
# 1. Notifications
# 1. Socials
# 1. Messages
# 1. Venues -- as proxy for locations

# == Fields planned
# 1. active_flag -- use to deactivate when the user has killed, in case there is other data we need to keep associated with this
# 1. group_flag -- we are really a group, and relationships are memberships in that group

class Person < ActiveRecord::Base

  ## include Searchy

  ## this line *creates* the attribute/method of Person called 'talks'
  has_many :talks, dependent: :destroy
  ## we are starting with the relationships that point 'to' the current person record

  # relationships

  ## this line *creates* the attribute/method of Person called 'relationships'
  ## 'followers' method created implicitly by the following:
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy

  ## and this *creates* the attribute/method of Person called 'followed_people'
  ## note that using 'has_many :followeds, through :relationships' would have worked automagically
  has_many :followed_people, through: :relationships, source: :followed, dependent: :destroy

  has_many :reverse_relationships, 
    foreign_key: "followed_id",
    class_name:  "Relationship",
    dependent:   :destroy

  ## 'source' is optional, since followers will automagically give follower_id as the key
  has_many :followers, through: :reverse_relationships, source: :follower

  # messages were setup in || with relationships
  # follower -> sender, followed -> receiver
  has_many :sent_messages, foreign_key: "sender_id", class_name: "Message", dependent: :destroy
  has_many :receivers, through: :sent_messages, source: :receivers, dependent: :destroy
  has_many :received_messages, foreign_key: "receiver_id", class_name: "Message", dependent: :destroy
  has_many :senders, through: :received_messages, source: :sender

  has_many :members, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :venues, dependent: :destroy
  has_many :socials, dependent: :destroy

  has_many :tags, :as => :tagable
  has_many :attachments, :as => :attachable

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

  def feed
    # could use 'talks' to get all of the associated talks!
    # Talk.where("person_id = ?", id)
    Talk.from_people_followed_by(self)  # which includes 'self', we always follow ourselves!
  end

  def following?(other_person)
    ## note there is an implicit 'self.' in front of the relationships
    relationships.find_by(followed_id: other_person.id)
  end

  def follow!(other_person)
    ## note there is an implicit 'self.' in front of the relationships
    ## logger.debug("ZZ: follow!: person = #{self.inspect}, other_person = #{other_person.inspect}")
    relationships.create!(followed_id: other_person.id)
  end

  def unfollow!(other_person)
    ## note there is an implicit 'self.' in front of the relationships
    ## logger.debug("ZZ: unfollow!: person = #{self.inspect}, other_person = #{other_person.inspect}")
    relationships.find_by(followed_id: other_person.id).destroy!
  end

  # default & simplest search
  def self.search(q)
    if q.present?
      where("name like ? or email like ?", "%#{q}%", "%#{q}%")
    else
      Person.all
    end
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
    logger.debug("MM: Person.anonymous: #{anonymous}")
    anonymous
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
