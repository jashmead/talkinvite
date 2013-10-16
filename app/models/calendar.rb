class Calendar < ActiveRecord::Base
  validates :chronometry, presence: true
  validates :settings, presence: true
  validates :history, presence: true
end
