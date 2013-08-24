class Talk < ActiveRecord::Base
  belongs_to :location
  has_many :posts
  has_many :tags, as: :tagable
end
