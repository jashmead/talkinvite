# People
# 
# == Fields
# 1.  name -- string, doesn't have to be unique (so long as email is!), but is mandatory
# 1.  email -- mandatory, validated 
# 1.  description -- text, optional
# 1.  admin -- boolean, administrator, includes talkinvite
# 1.  password, password_confirmation, encrypted_password -- per devise
#
# NOTE:  password_digest & remember_token both in use in 'devise'; do not remove
#   -- see code in /Users/taqm/.rvm/gems/ruby-2.0.0-p247/gems/devise-3.2.2/lib/devise/models
# 
# == Children

# 1. Talks
# 1. Services
# 1. Posts -- includes comments
# 1. Members
# 1. Messages -- from sender & from receiver
# 1. Calendars
# 1. Maps

# == Fields contemplated
# 1. active_flag -- use to deactivate when the user has killed, in case there is other data we need to keep associated with this
# 1. current_talk_id -- store that id in the database -- or in sessions?
# 1. url -- bad for security reasons, since would be user supplied
# 1. photo -- see attachments
# 1. preferred start page (currently defaulting to sitemap), can store in session as last page

class Person < ActiveRecord::Base
  # Include default devise modules. Others available are: :confirmable, :lockable, :timeoutable and :omniauthable
  #   -- we may want to include confirmable at some point
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## this line *creates* the attribute/method of Person called 'talks'
  has_many :talks, inverse_of: :person, dependent: :destroy

  has_many :services, inverse_of: :person, dependent: :destroy

  has_many :posts, inverse_of: :person, dependent: :destroy

  has_many :members, inverse_of: :person, dependent: :destroy
  has_many :memberships, inverse_of: :person, through: :members, source: :talks

  has_many :sent_messages, inverse_of: :person, foreign_key: "sender_id", class_name: "Message", dependent: :destroy
  has_many :receivers, inverse_of: :person, through: :sent_messages, source: :receivers, dependent: :destroy
  has_many :received_messages, inverse_of: :person, foreign_key: "receiver_id", class_name: "Message", dependent: :destroy
  has_many :senders, inverse_of: :person, through: :received_messages, source: :sender

  has_many :maps, inverse_of: :person, dependent: :destroy
  has_many :calendars, inverse_of: :person, dependent: :destroy

  # before_create :create_remember_token

  before_save do
    # note:  name can be arbitrary case & have spaces
    self.email = email.downcase
  end

  after_save :create_talkinvite_service

  ## the '->' denotes a proc or lambda, scheduled for lazy evaluation
  default_scope -> { order('people.name asc') }

  validates :name, presence: true, length: { maximum: 80 }, uniqueness: true

  # since uniqueness of email being checked by device, do not check here
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX } #, #uniqueness: true

  # attr_accessible has been replaced by strong parameters

  # TBD: why can't anonymous be defined in the helpers?
  def self.anonymous 
    begin 
      self.find_by_name!('anonymous')
    end
  end

  # TBD:  add in create of default service?
  # TBD:  replace force with find_or_create?
  def self.force!(name, email, password, options = {})
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

    # make sure that every person has at least the 'talkinvite' service
    def create_talkinvite_service
      # logger.debug("Person.create_talkinvite_service: self: #{self.inspect}")

      # TBD: shift from id to new_record?
      if self.id?
        # logger.debug("Person.create_talkinvite_service: self.id: #{self.id.inspect}")
        @services = Service.where('person_id = ? and service_type = ?', self.id, 'talkinvite')
        if ! @services || @services.size == 0
          Service.create!( person_id: self.id, service_type: 'talkinvite' )
        end
      end

    end

end
