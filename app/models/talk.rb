# Talks -- Key table
# 
# == Fields
# 1. person_id -- hope to allow anonymous at some point, but not clear how to do this
# 1. summary -- string, mandatory, counts as 'what'
# 1. description -- text, optional, counts as 'why'
# 1. start_dt -- when it is supposed to start, defaults to 15 minutes from now, rounded up
# 1. end_dt -- could have used duration, but end_dt is more intuitive, with start_dt, heart of 'when', replace with duration?
# 1. talk_status -- posted talks are those that have been posted & not cancelled or finished
# 1. where_desc -- key word or address; rename as address
# 1. longitude -- x coordinate, not visible to users
# 1. latitude -- y coordinate, not visible to users
# 1. who_type -- as any, members_only, ...

# -- get posted datetime from posts

# == Children

# 1. Members
# 1. Comments
# 1. Posts
# 1. Maps

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
for associations

use association to fetch, build + = to create in memory, create to build & save at the same time
  TBD:  does 'update' on parent automagically save the children?  can check the logs to see, or check the ActiveRecord docs

going from child to parent (talk to person) we have:

  assocation, 
  association=, 
  build_association (in memory only), 
  create_association (in memory & on disk)

  example:  @talk.person, @talk.person=, @talk.build_person, @talk.create_person

going from parent to child (talk to posts, members, & comments) we have:

  children(force_reload = false)
  children<<(object, ...)
  children.delete(object, ...)
  children.destroy(object, ...)
  children=objects
  child_ids
  child_ids=ids
  children.clear
  children.empty?
  children.size
  children.find(...)
  children.where(...)
  children.exists?(...)
  children.build(attributes = {}, ...)
  children.create(attributes = {})

  @talk.posts, @talk.posts<<(post, ...), @talk.posts.delete(post,...), @talk.posts.destroy(post,...),
    @talk.posts = posts, @talk.post_ids, @talk.post_ids = ids, @talk.posts.clear, @talk.posts.empty?,
    @talk.posts.size, @talk.posts.find(post_id,...), @talk.posts.where(post where condition),
    @talk.posts.exists? (check for posts?), @talk.posts.build(attributes = {}, ...), 
    @talk.create(attributes = {}, ...)

=end

class Talk < ActiveRecord::Base

  include ActiveModel::Validations
  validates_with TalkValidator

  belongs_to :person, inverse_of: :talks

  has_many :members, inverse_of: :talk, dependent: :destroy
  has_many :guests, inverse_of: :person, through: :members, source: :talks

  has_many :comments, inverse_of: :talk, dependent: :destroy
  has_many :posts, inverse_of: :talk, dependent: :destroy

  # Note:  we are *not* using has_many :messages here;
  #   -- having two paths from people to messages (direct & via talks) seems to confuse RoR

  ## note: the '->' denotes a proc or lambda, scheduled for lazy evaluation
  default_scope -> { order('talks.updated_at desc') }

  validates :summary, presence: true, length: { minimum: 1, maximum: 255 }
  validates :person_id, presence: true
  validates_inclusion_of :talk_status, in: [ 'start', 'posted', 'cancelled', 'done' ] 

  def self.posted
    # TBD:  use scopes to help collect 'posted'?
    self.where('talk_status = ?', 'posted')
  end

  # TBD:  upgrade talks_by_person to include memberships
  def self.talks_by_person( person ) 
    if ! person
      # TBD:  is 'none' the right way to return an empty set of relations?
      return none 
    end
    # TBD: does find_by_person_id throw exception on no rows found?
    # TBD: replace this with a union on all members but only active
    self.where('person_id = ?', person.id)
  end

end
