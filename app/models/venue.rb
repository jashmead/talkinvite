# == Fields
# 1. person_id -- creator
# 1. venue_type -- venues (obvious), people (current location of person), talks (venue associated with a particular talk), '' for anything else
# 1. name 
# 1. description 
# 1. longitude -- decimal
# 1. latitude -- decimal

# == Children
# 1. Talks -- creator

# Planned or at least contemplated fields:
# 1. map_type
# 1. full_address
# 1. broken out parts of full_address: street1, street2, city, state, post_code (zip)
# 1. country
# 1. phone(s) -- needed if we are using the contacts?
# 1. url(s) -- from attachments? from contacts?
# 1. email(s) -- from contacts?
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
  validates_inclusion_of :venue_type, :in => [ '', 'venues', 'people', 'talks' ]

end
