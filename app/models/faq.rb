# FAQS
#
# faqs will double as help texts, tho we have not yet worked out mechanics of this, perhaps a subject or how to field
#   -- currently using the presence of 'How ' at the front of the question to indicate this is a help record, 
#   -- crude but not completely contemptible
#   -- should be able to do this within the model; currently handled at the controller level
#
# question is unique, with respect to answers:  there can be only one!
#
# expect will often have attachment url's here, pointing to more detailed pages
#   and tags

class Faq < ActiveRecord::Base
  validates :question, presence: true
  validates_uniqueness_of :question
  validates :answer, presence: true

  default_scope -> { order('faqs.question asc') }
end
