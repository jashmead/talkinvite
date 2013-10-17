# FAQS
#
# faqs will double as help texts, tho we have not yet worked out mechanics of this, perhaps a subject or how to field
#
# could make the question unique
#
# expect will often have attachment url's here, pointing to more detailed pages
#   and tags

class Faq < ActiveRecord::Base
  validates :question, presence: true
  validates_uniqueness_of :question
  validates :answer, presence: true

  default_scope -> { order('faqs.question asc') }

  # default & simplest search
  def self.search(q)
    if q.present?
      q_like = "%#{q}%"
      where("question like ? or answer like ?", q_like, q_like)
    else
      Faq.all
    end
  end

end
