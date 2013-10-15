class Comment < ActiveRecord::Base

  belongs_to :person
  belongs_to :talk

  validates :person_id, presence: true

  validates :talk_id, presence: true

  validates :comment_text, presence: true

  validates_uniqueness_of :person_id, :talk_id

end
