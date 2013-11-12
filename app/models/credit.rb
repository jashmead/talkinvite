# Credits
#
# Give credit to various deserving persons
#
# Expect we will add a 'url' field to this
#
class Credit < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name
  validates :description, presence: true

  default_scope -> { order('credits.name asc') }
end
