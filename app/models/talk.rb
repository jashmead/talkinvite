# Talks -- Key table
# 
# == Fields
# 1. person_id -- hope to allow anonymous at some point, but not clear how to do this
# 1. summary -- string, mandatory, counts as 'what'
# 1. description -- text, optional, counts as 'why'
# 1. start_dt -- when it is supposed to start, defaults to 15 minutes from now, rounded up
# 1. end_dt -- could have used duration, but end_dt is more intuitive, with start_dt, heart of 'when'
# 1. posted_dt -- when this is announced to the world
# 1. talk_status -- posted talks are those that have been posted & not cancelled or finished
# 1. where_desc
# 1. who_type -- as any, members_only, ...
# 1. why_type -- ?

# == Children
# 1. Members
# 1. Comments
# 1. Posts

# Planned fields
# 1. repeating talk?
# 1. private talk?
# 1. open -- anyone can edit?
# 1. post talk comments

# == Searches
#
# 1. My talks
# 1. My current talks
# 1. By tag -- once tags are in
# 1. By topic -- once topics are in
# 1. Advanced:  by name, description, url, and so on
# 1. Like a previous talk
# 1. Like my other talks
# 1. Associated with a group -- once groups are in
# 1. Nearby -- once locations are up
# 1. Liked by X, with X as a member
#
# TBD: validate start_dt < end_dt

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

  validates_inclusion_of :talk_status, in: [ 'start', 'posted', 'cancelled', 'done' ] 

  # TBD: is talks_by_person needed? the association methods should be able to take care of this
  def self.talks_by_person( person ) 
    # RoR probably knows to use 'id' when called with 'person', experiment later
    if ! person
      return none # TBD:  is 'none' the right way to return an empty set of relations?
    end
    # TBD: does find_by_person_id throw exception on no rows found?
    self.where('person_id = ?', person.id)
  end

end
