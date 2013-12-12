#
# Services
#
# Point up to people
#
# restricted types, but as yet no service_types table planned
#
class Service < ActiveRecord::Base

  # talkvite is base, mediated via messages in database
  # dm is local messaging, mediated via javascript
  SERVICE_TYPES = [ 'talkinvite', 'email', 'dm', 'twitter', 'facebook', 'google+' ]

  belongs_to :person, inverse_of: :services

  validates :person_id, presence: true
  validates :service_type, presence: true

  validates_inclusion_of :service_type, :in => SERVICE_TYPES

end
