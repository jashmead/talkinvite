#
# Comments 
#
# Child of talks
#
# May have polymorphism in its future
# In that case, will need a commentable_type & commentable_id field, latter replacing talk_id
#
# Posts are comments that change the talks status, comments are posts that don't change the status

class Comment < ActiveRecord::Base

  belongs_to :person, inverse_of: :comments
  belongs_to :talk, inverse_of: :comments

  ## default scope is not working in new/older tests
  default_scope -> { order('comments.created_at desc') }

  validates :person_id, presence: true

  validates :talk_id, presence: true

  validates :comment_text, presence: true

  ## searches:  given person & talk, get all comments in reverse updated_at order

end
