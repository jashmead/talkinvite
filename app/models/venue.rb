# == Fields
# 1. person_id -- creator
# 1. venue_type -- personal, anonymous, venue
# 1. name 
# 1. description 
# 1. longitude -- decimal
# 1. latitude -- decimal

# == Children
# 1. Talks

# Planned or at least contemplated fields:
# 1. map_type
# 1. full_address
# 1. broken out parts of full_address
# 1. country?
# 1. phone(s)
# 1. url(s)
# 1. email(s)
#
# Searches by name, description, venue_type, & location possible
#   start with name & description & venue_type
# Start with PostgreSQL native location stuff, easier to get started with

class Venue < ActiveRecord::Base
  belongs_to :person
  
  has_many :talks
  has_many :tags, :as => :tagable
  has_many :attachments, :as => :attachable

  validates :person_id, presence: true
  validates :name, presence: true
  validates_inclusion_of :venue_type, :in => [ 'venue', 'person', 'talk', 'attachment', 'tag', 'social', 'message' ] # singleton name of table using venue

end
