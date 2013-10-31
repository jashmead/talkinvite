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
# 
# could merge credits & static pages into this as well
#   -- in this case, modify uniqueness to apply to name + type
#   -- and may also want to create a tag, a handle to make the record easy to find
#   -- and a flag or some such marking specific records as do not edit
#   -- faq_types:  faq, credit, static, bug/feature request, ...
# 
# faqs we are planning:
#   -- why the colors?
#   -- why the site? (& see about)
#   -- how built?
#   -- why do you need to be signed in?  -- easier, frankly
#   -- why ads?  -- have to pay to keep the servers spinning, seemed more appropriate, especially if ads relevant

class Faq < ActiveRecord::Base
  validates :question, presence: true
  validates_uniqueness_of :question
  validates :answer, presence: true
  validates :faq_type, presence: true
  validates_inclusion_of :faq_type, :in => [ 'faq', 'help', 'credit' ]

  default_scope -> { order('faqs.question asc') }
end
