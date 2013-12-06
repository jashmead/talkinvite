# Helps
#
# helps.name is unique & space-free
#
# those helps associated with pages can be edited on the fly by any admin, helps to keep them up to date
#
# TBD:  add url field -- note that this can be included in the description
# TBD:  add html_id field? or just keep using name for this?
# TBD:  add in help_type:  page, faq, topic, ...
#
# currently keying off the 'id' for the page, this should work for partials as well...

class Help < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name
  validates :description, presence: true

  default_scope -> { order('helps.name asc') }
end
