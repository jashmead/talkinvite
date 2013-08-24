class Person < ActiveRecord::Base
  has_many :posts
  has_many :tags, as: :tagable
end
