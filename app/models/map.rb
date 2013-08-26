# Map -- virtual table at this point, maintained to give ruby-oid structure to web pages
# 
# Associated with anything with a location
# 
# Fields:
# 1.  name -- string, optional!
# 1.  description -- text, still more optional!
# 1.  location_id -- integer, pointer to location, mandatory
# 1.  source -- string, i.e. talks + a query, mandatory
# 1.  settings -- internal controls, as zoom level, bounding box, & so on, optional
# 
# 
class Map < ActiveRecord::Base
  validates :person_id, presence: true
  validates :location_id, presence: true
  validates :source, presence: true

  belongs_to :location
end
