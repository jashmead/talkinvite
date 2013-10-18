# Talks -- Key table, this is what we invite people to!
# 
# == Fields
# 1. summary -- string, mandatory
# 1. description -- text, optional

# == Children
# 1. Members
# 1. Comments
# 1. Notifications
# 1. Socials
# 1. Venues -- as proxy for locations

# Planned fields
# 1. venue_id

# do all the searches here, not in controller

=begin
  To go back & forth between people & talks:
    talk.person -- creator
    person.talks -- their talks
    person.talks.create(arg) -- create a talk for the person
    person.talks.create!(arg) -- create a talk for the person, die on failure
    person.talks.build(arg) -- build a new talk for the person, not (yet) saved to the database
  Using these instead of:
    Talk.create
    Talk.create!
    Talk.new
=end

class Talk < ActiveRecord::Base

  ## include Searchy

  belongs_to :person
  belongs_to :venue

  has_many :members, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :socials, dependent: :destroy
  has_many :tags, :as => :tagable
  has_many :attachments, :as => :attachable

  ## the '->' denotes a proc or lambda, scheduled for lazy evaluation
  default_scope -> { order('talks.created_at desc') }

  validates :summary, presence: true, length: { minimum: 6, maximum: 255 }
  validates :person_id, presence: true

  ## why is the 'self.' needed?
  def self.from_people_followed_by(person)
    ## followed_people association will automagically return an array of ids from followed_people
    ## pluralization is changing followed_people to followed_person_ids
    ## when invoked in 'where' content, association ids array joins itself with commas
    ## apparently the following 'where' applies to how the followed_person_ids are found
    ## followed_person_ids = person.followed_person_ids
    followed_person_ids = "select followed_id from relationships where follower_id = :person_id"
    ## default context for where is 'talks'
    where( "person_id in (#{followed_person_ids}) or person_id = :person_id", person_id: person)
  end

  def self.recent
    # with default scope, the most recently changed
    talks = Talk.order('talks.updated_at desc').limit(10)
  end

  # for now, for hot_talks, just return the most recent
  #   if person argument supplied, then feature that person more prominently, somehow
  def self.hot_talks
    talks1 = self.recent.limit(10)
    logger.debug("MM: self.hot_talks: #{talks1.inspect}")
    talks1
  end

  ## check nearby in known talkinviters (who make their location known),
  ##  nearby according to twitter,
  ##  and so on
  def self.nearby (location) 
    # OK, how do we *really* do 'nearby'?
    self.recent
  end

  def self.talks_by_person( person ) 
    # RoR probably knows to use 'id' when called with 'person', experiment later
    if ! person
      person = Person.anonymous
    end
    self.find_by_person_id(person.id)
  end

  # troll web for quotes using the key_phrase
  def self.quote ( key_phrase )

  end

  # look for stuff in various categories
  def self.category( tag, key_phrase )

  end

  # look for hash_tags & other stuff on twitter
  def self.twitter( key_phrase ) 

  end
end
