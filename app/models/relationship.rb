class Relationship < ActiveRecord::Base
<<<<<<< HEAD
  ## how are we sorting out which id goes with which belongs_to?

  ## this line creates the attribute/method called 'follower'
  ## presumably automagically hooks up to follower_id, 
  ##  so this can get us from follower_id to the corresponding Person vi relationship.follower_id->person.id
  belongs_to :follower, class_name: "Person"

  ## this line creates the attribute/method called 'followed'
  ## presumably automagically hooks up to followed_id
  ##  so this can get us from followed_id to the corresponding Person vi relationship.followed_id->person.id
  belongs_to :followed, class_name: "Person"

  ## add in not-nulls to this
  validates :follower_id, presence: true
  validates :followed_id, presence: true
=======

  belongs_to :from_person, class_name: "Person", foreign_key: 'from_id'
  belongs_to :to_person, class_name: "Person", foreign_key: 'to_id'

  validates :to_id, presence: true
  validates :from_id, presence: true
>>>>>>> relationships

end
