# Partners
#
# Fields
# 1. person_id
# 1. talk_id
# 1. rsvp_status -- yes, no
# 1. partner_type -- partner, admin -- could use admin_flag well
#
# TBD:  should be able to get at current partner_type & rsvp_status from the association functions

class Partner < ActiveRecord::Base

  RSVP_STATUSES = [ 'yes', 'no' ]
  MEMBER_TYPES = [ 'partner', 'admin' ]

  belongs_to :person, inverse_of: :partners
  belongs_to :talk, inverse_of: :partners

  ## default_scope is not working in the newer/older test
  default_scope -> { order('partners.created_at desc') }

  validates :person_id, presence: true
  validates :talk_id, presence: true

  validates :rsvp_status, presence: true
  validates_inclusion_of :rsvp_status, :in => RSVP_STATUSES

  validates :partner_type, presence: true
  validates_inclusion_of :partner_type, :in => MEMBER_TYPES  # may have others, ultimately

  # if no attributes supplied, return existing partner record or nil if there is none
  def self.find_by_person_and_talk(person_id, talk_id)
    Partner.where("person_id = ? and talk_id = ?", person_id, talk_id).first
  end

  def self.create_or_update(person_id, talk_id, attributes = nil)
    partner = Partner.find_by_person_and_talk(person_id, talk_id)
    if ! partner
      partner = Partner.new(person_id: person_id, talk_id: talk_id)
    end
    partner.update_attributes( attributes )
  end

  def self.no(person_id, talk_id)
    Partner.create_or_update(person_id, talk_id, rsvp_status: 'no')
  end

  def self.yes(person_id, talk_id)
    Partner.create_or_update(person_id, talk_id, rsvp_status: 'yes')
  end

  def self.admin(person_id, talk_id)
    # verify the person doing this is creator of talk or else an admin
    if ! person_signed_in? 
      return nil
    end

    talk = Talk.find(talk_id)
    if talk.person_id = person_id || talk.person_id == current_person.id
      return Partner.create_or_update(person_id, talk_id, partner_type: 'admin')
    end
      
    current_partner = Partner.find_by_person_and_talk(current_person.id, talk_id)
    if ! current_partner || current_partner.partner_type != 'admin'
      return nil
    end

    Partner.create_or_update(person_id, talk_id, partner_type: 'admin')
  end

  def self.unadmin(person_id, talk_id)
    if ! person_signed_in? || current_person.id == person_id
      return nil
    end

    talk = Talk.find(talk_id)
    if talk.person_id = person_id
      return nil
    end

    current_partner = Partner.find_by_person_and_talk(current_person.id, talk_id)
    if ! current_partner || current_partner.partner_type != 'admin' 
      return nil
    end

    Partner.create_or_update(person_id, talk_id, partner_type: 'partner')
  end

  # return nil partner not found
  def self.partner_type(person_id, talk_id) 
    partner = Partner.find_by_person_and_talk(person_id, talk_id)
    return partner && partner.partner_type
  end

  # return nil if partner not found
  def self.rsvp_status(person_id, talk_id) 
    partner = Partner.find_by_person_and_talk(person_id, talk_id)
    return partner && partner.rsvp_status
  end

  def self.admin? (person_id, talk_id) 
    if ! person_signed_in?
      return nil
    end

    talk = Talk.find(talk_id)
    if talk.person_id == person_id
      return true
    end

    partner = Partner.find_by_person_and_talk(person_id, talk_id)
    return partner & partner.partner_type == 'admin'
  end

  def self.is_coming? (person_id, talk_id) 
    partner = Partner.find_by_person_and_talk(person_id, talk_id)
    return partner && partner.rsvp_status == 'yes'
  end

  # TBD:  are_coming?

end
