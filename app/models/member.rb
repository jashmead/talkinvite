## methods needed:
#
# Fields
# 1. person_id
# 1. talk_id
# 1. rsvp_status -- accepted, declined, maybe
# 1. member_type -- member, admin
#
# TBD:  add a member.member_text field?

class Member < ActiveRecord::Base

  belongs_to :person, inverse_of: :members
  belongs_to :talk, inverse_of: :members

  ## default_scope is not working in the newer/older test
  default_scope -> { order('members.created_at desc') }

  validates :person_id, presence: true

  validates :talk_id, presence: true

  validates :rsvp_status, presence: true
  validates_inclusion_of :rsvp_status, :in => [ 'accepted', 'declined', 'maybe' ]

  validates :member_type, presence: true
  validates_inclusion_of :member_type, :in => [ 'member', 'admin' ]  # may have others, ultimately

  validates_uniqueness_of :person_id, :talk_id

  ## searches:  given person & talk, get all comments in reverse updated_at order

  ## make the status changing guys class methods because the member record may not exist
  def self.rsvp_status_create_or_change(person_id, talk_id, new_rsvp_status)
  end

  def self.member_type_create_or_change(person_id, talk_id, new_member_type)
  end

  def self.accept(person_id, talk_id)
    self.rsvp_status_create_or_change(person_id, talk_id, 'accepted')
  end

  def self.decline(person_id, talk_id)
    self.rsvp_status_create_or_change(person_id, talk_id, 'declined')
  end

  def self.maybe(person_id, talk_id)
    self.rsvp_status_create_or_change(person_id, talk_id, 'maybe')
  end

  def self.admin(person_id, talk_id)
    # verify the person doing this is creator of talk or else an admin
    self.member_type_create_or_change(person_id, talk_id, 'admin')
  end

  def self.unadmin(person_id, talk_id)
    # verify the person doing this is self & further is not the last admin!
    self.member_type_create_or_change(person_id, talk_id, 'member')
  end

end
