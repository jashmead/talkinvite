# Calendar -- virtual table at this point, maintained to give ruby-oid structure to web pages
#
# Associated with anything with a datetime, pretty much everything!
# 
# Fields:
# 1.  name -- string
# 1.  description -- text
# 1.  timepoint -- datetime, center of time
# 1.  source -- string, i.e. talks + a query
# 1.  settings -- internal controls, as zoom level, bounding box, & so on
# 
# 
class Calendar < ActiveRecord::Base
end
