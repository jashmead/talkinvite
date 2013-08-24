# Talks -- Key table, this is what we invite people to!
# 
# Currently, curiously short
# 
# == Fields
# 1. summary -- string, mandatory
# 2. description -- text, optional
# 3. location_id -- location, currently optional
# 
# == Relationships
# 1. Points up to location
# 1. Is tagable & fileable
# 
class Talk < ActiveRecord::Base
  belongs_to :location
  has_many :posts
  has_many :tags, as: :tagable
end
