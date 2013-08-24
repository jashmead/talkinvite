class Post < ActiveRecord::Base
  belongs_to :person
  belongs_to :talk
end
