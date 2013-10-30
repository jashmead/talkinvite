# Tags
#
# Fields are a bare minimum:  
# 1. tag_type -- the actual 'tag', not the type of tag (now that is confusing!), but then the tag itself might come out as tag_tag
# 1. tagable_type -- name of the parent table
# 1. tagable_id -- id of parent record
#
# There is a unique key on these three
#
# there is no creator_id, for simplicity
# TBD:  see if we would like to have a creator tag, might make some things easier
#
# tagging currently applies to talks, venues, & people
# -- may extend in future
#
# we are assuming that each tag is focused on a specific target record, making polymorphism appropriate
#

class Tag < ActiveRecord::Base
  belongs_to :tagable, :polymorphic => true

  validates :tag_type, presence: true
  validates :tagable_id, presence: true
  validates :tagable_type, presence: true

  # may be adding attachments & perhaps others to this list
  validates_inclusion_of :tagable_type, :in => [ 'talks', 'venues', 'people' ]

  # there will probably be reverse searches here, we have already created the corresponding index
end
