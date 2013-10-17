#
# Credits
#
# no search on credits
#
# expect will normally have attachment url's here, at a minimum
#   and tags

class Credit < ActiveRecord::Base

  validates :worthy_one, presence: true
  validates_uniqueness_of :worthy_one
  validates :service_supplied, presence: true

  default_scope -> { order('credits.worthy_one asc') }

  # default & simplest search
  def self.search(q)
    if q.present?
      q_like = "%#{q}%"
      where("worthy_one like ? or service_supplied like ?", q_like, q_like)
    else
      Credit.all
    end
  end

end
