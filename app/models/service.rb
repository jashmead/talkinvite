class Service < ActiveRecord::Base

  belongs_to :person, inverse_of: :services

  validates :person_id, presence: true
  validates :service_type, presence: true

  # probably a bunch of other types as well
  #   talkvite is base
  #   dm is local messaging
  # TBD:  figure out how to get this list to be returned from a function
  #   -- tried setting up Module with require, include, but relevant function not found
  validates_inclusion_of :service_type, :in => [ 'talkinvite', 'dm', 'twitter', 'facebook' ]

end
