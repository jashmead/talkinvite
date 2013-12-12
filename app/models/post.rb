#
# Posts
#
# Posts are comments that also change the state of the talk
#
class Post < ActiveRecord::Base

  # start is the default, announce is when you tell everyone, rest self-explanatory
  # these corresond to the buttons on the talk
  # NOTE:  
  #   -- can't logically announce a delete, since there is in this case no talk to post about (was just killed):)
  #   -- by same logic, no draft announcement, as no talk yet
  POST_TYPES = [ 'announce', 'cancel', 'change', 'done', 'reopen' ]

  belongs_to :person, inverse_of: :posts
  belongs_to :talk, inverse_of: :posts

  default_scope -> { order('posts.created_at desc') }

  validates :person_id, presence: true  # note person_id points to author of post, *NOT* author of talk
  validates :talk_id, presence: true
  validates :post_type, presence: true
  validates :post_title, presence: true

  # routing is combination of service types to use, default 'message'
  #   -- format with '+', i.e. 'message+email'
  # TBD:  add a validation block to make sure that all parts are legit service types
  validates :routing, presence: true 

  validates_inclusion_of :post_type, :in => POST_TYPES

end
