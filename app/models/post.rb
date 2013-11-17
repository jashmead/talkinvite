#
# Posts
#
# Posts are comments that also change the state of the talk
#
class Post < ActiveRecord::Base

  belongs_to :person, inverse_of: :posts
  belongs_to :talk, inverse_of: :posts

  default_scope -> { order('posts.created_at desc') }

  validates :person_id, presence: true  # note person_id points to author of post, *NOT* author of talk
  validates :talk_id, presence: true
  validates :service_type, presence: true # how the post is being shipped out
  validates :post_type, presence: true

  # TBD: figure out how to get the service list from shared code, say in the module Talkinvite
  validates_inclusion_of :service_type, :in => [ 'talkinvite', 'email', 'twitter', 'facebook', 'dm' ]

  validates_inclusion_of :post_type, :in => [ 'announce', 'cancel', 'done' ]

end
