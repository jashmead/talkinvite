class Service < ActiveRecord::Base
  belongs_to :person, inverse_of: :services

  validates :person_id, presence: true
  validates :service_type, presence: true

  validates_inclusion_of :service_type, :in => [ 'talkinvite' ]
end
