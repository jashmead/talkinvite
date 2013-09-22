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
# 1. talks -- child

class Person < ActiveRecord::Base

  ## this line *creates* the attribute/method of Person called 'talks'
  has_many :talks, dependent: :destroy

  ## this line *creates* the attribute/method of Person called 'relationships'
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy

  ## and this *creates* the attribute/method of Person called 'followed_people'
  ## note that using 'has_many :followeds, through :relationships' would have worked automagically
  has_many :followed_people, through: :relationships, source: :followed, dependent: :destroy

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

  def following?(other_person)
    ## note there is an implicit 'self.' in front of the relationships
    relationships.find_by(followed_id: other_person.id)
  end

  def follow!(other_person)
    ## note there is an implicit 'self.' in front of the relationships
    logger.debug("ZZ: follow!: person = #{self.inspect}, other_person = #{other_person.inspect}")
    relationships.create!(followed_id: other_person.id)
  end

  def unfollow!(other_person)
    ## note there is an implicit 'self.' in front of the relationships
    logger.debug("ZZ: unfollow!: person = #{self.inspect}, other_person = #{other_person.inspect}")
    relationships.find_by(followed_id: other_person.id).destroy!
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
