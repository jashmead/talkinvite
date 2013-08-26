# Calendar -- virtual table at this point, maintained to give ruby-oid structure to web pages
#
# Associated with anything with a datetime, pretty much everything!
# 
# Fields:
# 1.  name -- string, optional!
# 1.  description -- text, still more optional!
# 1.  timepoint -- datetime, center of time, mandatory
# 1.  source -- string, i.e. talks + a query, mandatory
# 1.  settings -- internal controls, as zoom level, bounding box, & so on
# 
# 
class Calendar < ActiveRecord::Base
  validates :person_id, presence: true
  validates :time_point, presence: true
  validates :source, presence: true
end
