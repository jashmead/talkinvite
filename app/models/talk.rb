# Talks -- Key table, this is what we invite people to!
# 
# Currently, curiously short
# 
# == Fields
# 1. summary -- string, mandatory
# 2. description -- text, optional
# 3. location_id -- location, currently optional
#
# == Possible Fields
# 1. person_id, integer -- id of person creating the talk (in a database sense)
# 
# == Relationships
# 1. Points up to location
# 1. Is tagable & fileable
# 
# == Subtleties
# 1. There is no 'person_id' field:  this is handled by the posts table, which has a type of 'creator', since there can be two+ creators
class Talk < ActiveRecord::Base
  validates :summary, presence: true, length: { minimum: 2 }

  belongs_to :location
  has_many :posts
  has_many :tags, as: :tagable
  has_many :attachments, as: :attachable
end
