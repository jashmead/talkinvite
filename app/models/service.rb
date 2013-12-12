#
# Services
#
# Point up to people
#
# restricted types, but as yet no service_types table planned
#
class Service < ActiveRecord::Base

  # talkvite is base, mediated via messages in database
  # comment = don't send, just attach to the talk
  # message = add to message table
  # dm is local messaging, mediated via javascript
  # email = email
  # dm = direct mail (will need javascript & push)
  # twitter = post to twitter
  # facebook & google the same as twitter
  SERVICE_TYPES = [ 'talkinvite', 'comment', 'message', 'email', 'dm', 'twitter', 'facebook', 'google+' ]

  belongs_to :person, inverse_of: :services

  validates :person_id, presence: true
  validates :service_type, presence: true

  validates_inclusion_of :service_type, :in => SERVICE_TYPES

end
