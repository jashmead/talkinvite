#
# Posts
#
# Posts are comments that also change the state of the talk
#
class Post < ActiveRecord::Base

  belongs_to :person, inverse_of: :posts
  belongs_to :talk, inverse_of: :posts

  ## default_scope is not working in the newer/older test
  default_scope -> { order('posts.created_at desc') }

  validates :person_id, presence: true
  validates :talk_id, presence: true
  validates :service_type, presence: true
  validates :post_type, presence: true

  # TBD: figure out how to get the lists from shared code, say in the module Talkinvite
  validates_inclusion_of :service_type, :in => [ 'talkinvite', 'dm', 'twitter', 'facebook' ]
  validates_inclusion_of :post_type, :in => [ 'announce', 'cancel', 'conclude' ]

end
