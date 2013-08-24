class Talk < ActiveRecord::Base
  belongs_to :location
  has_many :posts
end
