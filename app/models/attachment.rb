# Attachments
#
# Fields are:
# 1. name
# 1. description -- optional
# 1. attachment_type -- image, self-portrait, commentary, pdf, movie, and so on -- loose
# 1. attachable_type -- name of the parent table
# 1. attachable_id -- id of parent record
# 1. file_path -- for now, optional, but if present, unique
#
# there is no creator_id, for simplicity
#
# attaching currently applies to talks, venues, & people
# -- may extend in future
#
# we are assuming that each attachment is focused on a specific target record, making polymorphism appropriate

class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true

  validates :name, presence: true

  validates :attachable_type, presence: true  # i.e. image

  validates :attachment_type, presence: true

  # may be adding attachments & perhaps others to this list
  # if attachable_type is a 'url', then the file_path is the 'url' in question
  validates_inclusion_of :attachable_type, :in => [ 'talks', 'venues', 'people', 'urls', 'faqs', 'credits', 'maps', 'calendars', 'credits' ]

  validates :attachable_id, presence: true

  # we will need file_path operators here
end
