# Partners
#
# Fields
# 1. person_id
# 1. talk_id
# 1. rsvp_status -- yes, no
# 1. partner_type -- partner, admin
#
# note:  should be able to get at current partner_type & rsvp_status from the association functions

class Partner < ActiveRecord::Base

  RSVP_STATUSES = [ 'yes', 'no' ]
  MEMBER_TYPES = [ 'partner', 'admin' ]

  belongs_to :person, inverse_of: :partners
  belongs_to :talk, inverse_of: :partners

  ## default_scope is not working in the newer/older test
  default_scope -> { order('partners.created_at desc') }

  validates :person_id, presence: true
  validates :talk_id, presence: true
  validates_uniqueness_of :person_id, :talk_id

  validates :rsvp_status, presence: true
  validates_inclusion_of :rsvp_status, :in => RSVP_STATUSES

  validates :partner_type, presence: true
  validates_inclusion_of :partner_type, :in => MEMBER_TYPES  # may have others, ultimately

  # if no attributes supplied, return existing partner record or nil if there is none
  # NOTE:  person# is first, talk# second
  def self.partnership(person_id, talk_id, attributes = nil)
    partner = Partner.where("person_id = ? and talk_id = ?", person_id, talk_id).first
    if ! attributes
      return partner # expect nil if no partner found
    end
    if ! partner
      partner = Partner.new(person_id: person_id, talk_id: talk_id)
    end
    partner.update_attributes( attributes )
  end

  def self.rsvp_status_create_or_change(person_id, talk_id, new_rsvp_status)
    Partner.partnership(person_id, talk_id, 'rsvp_status' => new_rsvp_status)
  end

  def self.partner_type_create_or_change(person_id, talk_id, new_partner_type)
    Partner.partnership(person_id, talk_id, 'partner_type' => new_partner_type)
  end

  def self.accept(person_id, talk_id)
    self.rsvp_status_create_or_change(person_id, talk_id, 'yes')
  end

  def self.decline(person_id, talk_id)
    self.rsvp_status_create_or_change(person_id, talk_id, 'no')
  end

  def self.admin(person_id, talk_id)
    # verify the person doing this is creator of talk or else an admin
    self.partner_type_create_or_change(person_id, talk_id, 'admin')
  end

  def self.unadmin(person_id, talk_id)
    # verify the person doing this is self & further is not the last admin!
    self.partner_type_create_or_change(person_id, talk_id, 'partner')
  end

  # return nil if no partnership
  def self.partner_type(person_id, talk_id) 
    partner = self.partnership(person_id, talk_id)
    return partner && partner.partner_type
  end

  # return nil if no partnership
  def self.rsvp_status(person_id, talk_id) 
    partner = self.partnership(person_id, talk_id)
    return partner && partner.rsvp_status
  end

end
