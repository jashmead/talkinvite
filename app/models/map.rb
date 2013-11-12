#
# Maps
#
# Virtual table, used to help manage maps for talks
#
# we may generalize to include maps of people (by current location) or of topics (by associated location)
#
class Map < ActiveRecord::Base
  validates :geometry, presence: true
  validates :settings, presence: true
  validates :history, presence: true
end
