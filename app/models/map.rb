class Map < ActiveRecord::Base
  validates :geometry, presence: true
  validates :settings, presence: true
  validates :history, presence: true
end
