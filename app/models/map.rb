#
# Maps
#
# Virtual table, used to help manage maps for talks
#
# we may generalize to include maps of people (by current location) or of topics (by associated location)
#
# TBD: add a talk_id to point up to talks; see 2013/11/15 migrations for messages up to talks for model
# TBD: figure what geometry, settings, & history mean
# TBD: how are we going to use name, description fields?
class Map < ActiveRecord::Base

  belongs_to :talk, inverse_of: 'maps'

  validates :geometry, presence: true
  validates :settings, presence: true
  validates :history, presence: true

end
