class Credit < ActiveRecord::Base
  validates :worthy_one, presence: true
  validates_uniqueness_of :worthy_one
  validates :service_supplied, presence: true
end
