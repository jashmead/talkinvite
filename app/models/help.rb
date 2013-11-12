# Helps
#
# helps.name is unique & space-free
#
# those helps associated with pages can be edited on the fly by any admin, helps to keep them up to date
#
class Help < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name
  validates :description, presence: true

  default_scope -> { order('helps.name asc') }
end
