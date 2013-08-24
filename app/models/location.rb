# Locations -- map or virtual locations
# 
# Associated with talks, people, posts, tweets, possibly some other stuff
# 
# Places possibly a better word for this.
# 
# Currently breaking out the coordinates into longitude (x) & latitude (y),
# rather than creating a composite type for them.
# Simpler for getting started.
# 
# Fields:
# 1.  name -- string
# 1.  description -- text
# 1.  longitude -- float
# 1.  latitude -- float
# 1.  address -- text, full text. Adequate for getting started.
# 
# Possible additional fields:
# 1.  broken out address -- street, city, & so on.  Perhaps better as JSON
# 1.  location_type
# 
class Location < ActiveRecord::Base
  has_many :talks
  has_many :tags, as: :tagable
  has_many :attachments, as: :attachable
end
