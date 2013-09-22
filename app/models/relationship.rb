class Relationship < ActiveRecord::Base
  ## how are we sorting out which id goes with which belongs_to?

  ## this line creates the attribute/method called 'follower'
  belongs_to :follower, class_name: "Person"

  ## this line creates the attribute/method called 'followed'
  belongs_to :followed, class_name: "Person"

end
