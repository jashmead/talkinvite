# Talks -- Key table
# 
# == Fields
# 1. person_id -- hope to allow anonymous at some point, but not clear how to do this
# 1. summary -- string, mandatory, counts as 'what'
# 1. description -- text, optional, counts as 'why'
# 1. start_dt -- when it is supposed to start, defaults to 15 minutes from now, rounded up
# 1. end_dt -- could have used duration, but end_dt is more intuitive, with start_dt, heart of 'when'
# 1. posted_dt -- when this is announced to the world
# 1. talk_status -- active talks are those that have been posted & not cancelled
# 1. where_desc
# 1. who_type -- as any, members_only, ...
# 1. why_type -- ?

# == Children
# 1. Members
# 1. Comments
# 1. Posts

# Planned fields
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

  has_many :members, inverse_of: :talk, dependent: :destroy
  has_many :guests, inverse_of: :person, through: :members, source: :talks

  has_many :comments, inverse_of: :talk, dependent: :destroy
  has_many :posts, inverse_of: :talk, dependent: :destroy

  ## the '->' denotes a proc or lambda, scheduled for lazy evaluation
  default_scope -> { order('talks.updated_at desc') }

  validates :summary, presence: true, length: { minimum: 6, maximum: 255 }
  validates :person_id, presence: true

  validates_inclusion_of :talk_status, in: [ 'new', 'active', 'cancelled', 'done' ] 

  # is talks_by_person needed?
  def self.talks_by_person( person ) 
    # RoR probably knows to use 'id' when called with 'person', experiment later
    if ! person
      person = Person.anonymous
    end
    self.find_by_person_id(person.id)
  end

end
