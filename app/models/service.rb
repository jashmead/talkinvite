#
# Services
#
# Point up to people
#
# restricted types, but as yet no service_types table planned
#
class Service < ActiveRecord::Base

  belongs_to :person, inverse_of: :services

  validates :person_id, presence: true
  validates :service_type, presence: true

  # probably a bunch of other types as well
  #   talkvite is base
  #   dm is local messaging

  # TBD:  figure out how to get this list to be returned from a function
  #   -- tried setting up Module with require, include, but relevant function not found
  # validates_inclusion_of :service_type, :in => service_list()

  # TBD:  have other be programmable if that is doable...

  validates_inclusion_of :service_type, :in => [ 'talkinvite', 'dm', 'twitter', 'facebook', 'google+', 'other' ]

  # TBD:  use the 'force!' idea to force creation of services for the core people; good in seeds.rb
end
