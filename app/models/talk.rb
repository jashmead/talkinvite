# Talks -- Key table, this is what we invite people to!
# 
# == Fields
# 1. summary -- string, mandatory
# 2. description -- text, optional
#
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
  belongs_to :person

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

  # in general, search is model specific
  # need 'self' because this is a class method
  # talks#search & friends most important single part of the system...
=begin
  searches:
    search
    nearby
    recent
    my_talks
    hot_talks
=end

  def self.search(q)
    return Talk.all unless q.present?
    q_like = "%#{q}%"
    where("summary like ? or description like ?", q_like, q_like)
  end

  def self.recent
    # with default scope, the most recently changed
    Talk.order('talks.updated_at desc')
  end

  # for now, for hot_talks, just return the most recent
  #   if person argument supplied, then feature that person more prominently, somehow
  def self.hot_talks
    self.recent.limit('limit 10')
  end

  def self.nearby (location) 
    # OK, how do we *really* do 'nearby'?
    self.recent
  end

  def self.talks_by_person( person ) 
    # RoR probably knows to use 'id' when called with 'person', experiment later
    if ! person
      person = Person.anonymous
    end
    ## logger.debug("MM: Talk.talks_by_person: #{person.inspect}")
    self.where("person_id = ?", person)
  end

end
