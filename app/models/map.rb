# Map -- virtual table at this point, maintained to give ruby-oid structure to web pages
# 
# Associated with anything with a location
# 
# Fields:
# 1.  name -- string
# 1.  description -- text
# 1.  location_id -- integer, pointer to location
# 1.  source -- string, i.e. talks + a query
# 1.  settings -- internal controls, as zoom level, bounding box, & so on
# 
# 
class Map < ActiveRecord::Base
end
