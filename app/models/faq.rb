# FAQS
#
# faqs will double as help texts, tho we have not yet worked out mechanics of this, perhaps a subject or how to field
#
# could make the question unique

class Faq < ActiveRecord::Base
  validates :question, presence: true
  validates_uniqueness_of :question
  validates :answer, presence: true
end
