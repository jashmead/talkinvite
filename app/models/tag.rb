# Tags -- Polymorphic, point up to basically everything:
# * Talks
# * Users
# * Locations
# * Posts
# * Files
# * Tweets -- used to track HashTags
# 
# == Fields
# 1. tagable_type
# 1. tagable_id
# 1. tag_type -- default is '', normal tag, could be used for ratings
# 1. tag -- string, may be a de facto integer if this is a rating
# 
# == Possible Fields
# 1. comment/description -- text
# 
## get trigger support in for the tags (& in a bit for the files)
class Tag < ActiveRecord::Base
  belongs_to :tagable, polymorphic: true
end
