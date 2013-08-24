class Location < ActiveRecord::Base
  has_many :talks
  has_many :tags, as: :tagable
end
