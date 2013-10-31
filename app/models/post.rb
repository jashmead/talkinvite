class Post < ActiveRecord::Base

  belongs_to :person, inverse_of: :posts
  belongs_to :talk, inverse_of: :posts

  ## default_scope is not working in the newer/older test
  default_scope -> { order('posts.created_at desc') }

  validates :person_id, presence: true
  validates :talk_id, presence: true
  validates :service_type, presence: true
  validates :post_type, presence: true

  validates_inclusion_of :service_type, :in => [ 'talkinvite' ]
  validates_inclusion_of :post_type, :in => [ 'announce', 'change', 'cancel', 'done' ]  # may have others, ultimately

end
