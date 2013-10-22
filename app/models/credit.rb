#
# Credits
#
# no search on credits
#
# expect will normally have attachment url's here, at a minimum
#   and tags

class Credit < ActiveRecord::Base
  has_many :tags, :as => :tagable
  has_many :attachments, :as => :attachable

  validates :name, presence: true
  validates_uniqueness_of :name
  validates :description, presence: true

  default_scope -> { order('credits.name asc') }
end
