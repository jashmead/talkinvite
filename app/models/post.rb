#
# Posts
#
# Posts are comments that also change the state of the talk
#
class Post < ActiveRecord::Base

  # start is the default, announce is when you tell everyone, rest self-explanatory
  # these corresond to the buttons on the talk
  POST_TYPES = [ 'announce', 'cancel', 'change', 'done', 'reopen' ]

  belongs_to :person, inverse_of: :posts
  belongs_to :talk, inverse_of: :posts

  default_scope -> { order('posts.created_at desc') }

  validates :person_id, presence: true  # note person_id points to author of post, *NOT* author of talk
  validates :talk_id, presence: true
  validates :post_type, presence: true
  validates :service_type, presence: true # how the post is being shipped out:  can be one or more service types, separated by commas, start with just one type (talkinvite)

  # TBD: switch to comma separated list of service types in service_type, then validate with block of some kind:w
  validates_inclusion_of :service_type, :in => Service::SERVICE_TYPES
  validates_inclusion_of :post_type, :in => POST_TYPES

end
