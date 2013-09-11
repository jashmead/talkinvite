# Talks -- Key table, this is what we invite people to!
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
# == History
# 1. From Microposts in the tutorial
# 1. Adds description column
# 1. Adds location_id column

class Talk < ActiveRecord::Base
  validates :summary, presence: true, length: { minimum: 6 }
  validates :person_id, presence: true

  belongs_to :location
  has_many :posts
  has_many :tags, as: :tagable
  has_many :attachments, as: :attachable
end
