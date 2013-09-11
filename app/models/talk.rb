# Talks -- Key table, this is what we invite people to!
# 
# == Fields
# 1. summary -- string, mandatory
# 2. description -- text, optional
#

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
  default_scope -> { order('created_at desc') }

  validates :summary, presence: true, length: { minimum: 6 }
  validates :person_id, presence: true
end
