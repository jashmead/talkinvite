class Member < ActiveRecord::Base

  belongs_to :person
  belongs_to :talk

  validates :person_id, presence: true

  validates :talk_id, presence: true

  validates :rsvp_status, presence: true
  validates_inclusion_of :rsvp_status, :in => [ 'accepted', 'declined', 'maybe' ]

  validates :member_type, presence: true
  validates_inclusion_of :member_type, :in => [ 'member', 'admin' ]  # may have others, ultimately

  validates_uniqueness_of :person_id, :talk_id

end
