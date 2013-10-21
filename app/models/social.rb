#
# Social consolidates twitter, facebook, the long list of others
#
# social search should in general be conditioned on the current account,
# except when just probing for a subject, someone nearby, & so on
#
# Social types we might be interested in
# 1. talkinvite itself
# 1. twitter
# 1. facebook
# 1. reddit
# 1. youtube
# 1. google circles
# 1. ...

class Social < ActiveRecord::Base

  belongs_to :person
  belongs_to :talk

  ## default_scope is not working in the newer/older test
  default_scope -> { order('socials.created_at desc') }

  validates :person_id, presence: true
  validates :talk_id, presence: true
  validates :social_type, presence: true
  validates :social_text, presence: true

  validates_inclusion_of :social_type, :in => [ 'talkinvite', 'twitter', 'facebook' ]  # may have others, ultimately

  validates_uniqueness_of :person_id, :talk_id

  ## searches:  given person & talk, get all comments in reverse updated_at order
end
