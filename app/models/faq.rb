# FAQS
#
# question is unique, with respect to answers:  there can be only one!
#
# expect will often have attachment url's here, pointing to more detailed pages
#   and tags
# TBD:  add url field?
# TBD:  eliminate this table
# 
# faqs we are planning:
#   -- why the colors?
#   -- why the site? (& see about)
#   -- how built?
#   -- why do you need to be signed in?  -- easier, frankly
#   -- why ads?  -- have to pay to keep the servers spinning, seemed more appropriate, especially if ads relevant
#   -- if a talk is open, what is to keep any member from changing disastrously? fear of the schmoo award

class Faq < ActiveRecord::Base
  validates :question, presence: true
  validates_uniqueness_of :question
  validates :answer, presence: true

  default_scope -> { order('faqs.question asc') }
end
