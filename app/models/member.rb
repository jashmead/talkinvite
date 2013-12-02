# Members
#
# Fields
# 1. person_id
# 1. talk_id
# 1. rsvp_status -- accepted, declined, maybe
# 1. member_type -- member, admin
#
# TBD:  add comment field
# note:  should be able to get at current member_type & rsvp_status from the association functions

class Member < ActiveRecord::Base

  RSVP_STATUSES = [ 'yes', 'no', 'maybe' ]
  MEMBER_TYPES = [ 'member', 'admin' ]

  belongs_to :person, inverse_of: :members
  belongs_to :talk, inverse_of: :members

  ## default_scope is not working in the newer/older test
  default_scope -> { order('members.created_at desc') }

  validates :person_id, presence: true
  validates :talk_id, presence: true
  validates_uniqueness_of :person_id, :talk_id

  validates :rsvp_status, presence: true
  validates_inclusion_of :rsvp_status, :in => RSVP_STATUSES

  validates :member_type, presence: true
  validates_inclusion_of :member_type, :in => MEMBER_TYPES  # may have others, ultimately

  # if no attributes supplied, return existing member record or nil if there is none
  def self.membership(person_id, talk_id, attributes = nil)
    member = Member.where("person_id = ? and talk_id = ?", person_id, talk_id).first
    if ! attributes
      return member # expect nil if no member found
    end
    if ! member
      member = Member.new(person_id: person_id, talk_id: talk_id)
    end
    member.update_attributes( attributes )
  end

  def self.rsvp_status_create_or_change(person_id, talk_id, new_rsvp_status)
    Member.membership(person_id, talk_id, 'rsvp_status' => new_rsvp_status)
  end

  def self.member_type_create_or_change(person_id, talk_id, new_member_type)
    Member.membership(person_id, talk_id, 'member_type' => new_member_type)
  end

  def self.accept(person_id, talk_id)
    self.rsvp_status_create_or_change(person_id, talk_id, 'yes')
  end

  def self.decline(person_id, talk_id)
    self.rsvp_status_create_or_change(person_id, talk_id, 'no')
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

  # return nil if no membership
  def self.member_type(person_id, talk_id) 
    member = self.membership(person_id, talk_id)
    return member && member.member_type
  end

  # return nil if no membership
  def self.rsvp_status(person_id, talk_id) 
    member = self.membership(person_id, talk_id)
    return member && member.rsvp_status
  end

end
