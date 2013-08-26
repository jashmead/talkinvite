# Tags -- Polymorphic, point up to basically everything:
# * Talks
# * People
# * Locations
# * Posts
# * Files
# * Tweets -- used to track HashTags
# 
# == Fields
# 1. tagable_type, mandatory, one of the relevant table names
# 1. tagable_id, mandatory, one of the relevant table ids
# 1. tag_type -- default is '', normal tag, could be used for ratings, mandatory, one of allowed types
# 1. tag -- string, may be a de facto integer if this is a rating, mandatory
# 
# == Possible Fields
# 1. comment/description -- text
# 
## get trigger support in for the tags
class Tag < ActiveRecord::Base

  validates :tag, presence: true
  validates :tag_type, presence: true
  validates :tagable_type, presence: true
  validates :tagable_id, presence: true

  # validates_format_of :tagable_type, :with => /\A(people|talks|posts|locations|files|tweets)\z/
  validates_inclusion_of :tagable_type, 
    :in => [ 'people', 'talks', 'posts', 'locations', 'files', 'tweets' ],
    :message => "Invalid table name"

  before_save { self.tagable_type.downcase! }

  belongs_to :tagable, polymorphic: true
end
