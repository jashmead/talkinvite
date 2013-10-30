# Talks -- Key table
# 
# == Fields
# 1. person_id -- hope to allow anonymous at some point, but not clear how to do this
# 1. summary -- string, mandatory, counts as 'what'
# 1. description -- text, optional, counts as 'why'
# 1. start_dt -- when it is supposed to start, defaults to 15 minutes from now, rounded up
# 1. end_dt -- could have used duration, but end_dt is more intuitive, with start_dt, heart of 'when'
# 1. venue_id -- venue is a general term for location, part of 'where'; may want to get more specific; we'll see
# 1. posted_dt -- when this is announced to the world
# 1. active_flag -- active talks are those that have been posted & not cancelled

# == Children
# 1. Members
# 1. Comments
# 1. Notifications
# 1. Socials

# Planned fields
# 1. venue_desc -- string, is 'where_type', as 'here' or tags
# 1. who_type -- as any, members_only, ...
# 1. why_type -- ?
# 1. repeating talk?

# TBD: validate start_dt < end_dt
# TBD: instantiate the many searches we have listed here

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

  belongs_to :person, inverse_of: :talks
  belongs_to :venue, inverse_of: :talks

  has_many :members, inverse_of: :talk, dependent: :destroy
  has_many :comments, inverse_of: :talk, dependent: :destroy
  has_many :notifications, inverse_of: :talk, dependent: :destroy
  has_many :socials, inverse_of: :talk, dependent: :destroy
  has_many :tags, :as => :tagable
  has_many :attachments, :as => :attachable

  ## the '->' denotes a proc or lambda, scheduled for lazy evaluation
  default_scope -> { order('talks.updated_at desc') }

  validates :summary, presence: true, length: { minimum: 6, maximum: 255 }
  validates :person_id, presence: true

  ## why is the 'self.' needed? -- because it is a class method, not an instance method
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

  def self.recent (location)
    # with default scope, the most recently changed
    logger.debug("Talk.recent")
    Talk.limit(10)
  end

  ## check nearby in known talkinviters (who make their location known),
  ##  nearby according to twitter,
  ##  and so on
  def self.nearby (location) 
    # OK, how do we *really* do 'nearby'?
    self.recent
  end

  # is talks_by_person needed?
  def self.talks_by_person( person ) 
    # RoR probably knows to use 'id' when called with 'person', experiment later
    if ! person
      person = Person.anonymous
    end
    self.find_by_person_id(person.id)
  end

end
