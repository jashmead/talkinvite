#
# calendars
#
# Virtual table, used to help manage calendars for talks
#
# we may generalize to include calendars of people (by current location) or of topics (by associated location)
#
# TBD: add a talk_id to point up to talks; see 2013/11/15 migrations for messages up to talks for model
# TBD: figure what geometry, settings, & history mean
# TBD: how are we going to use name, description fields?
class Calendar < ActiveRecord::Base

  belongs_to :person, inverse_of: :calendars
  belongs_to :talk, inverse_of: :calendars

  validates :person_id, presence: true
  validates :talk_id, presence: true
  validates :name, presence: true
  validates_inclusion_of :scale, in: [ 'day', 'week', 'month', 'year' ] 

end
