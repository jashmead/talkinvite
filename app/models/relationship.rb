class Relationship < ActiveRecord::Base
  belongs_to :from_person, class_name: "Person", foreign_key: 'from_id'
  belongs_to :to_person, class_name: "Person", foreign_key: 'to_id'
  validates :to_id, presence: true
  validates :from_id, presence: true
end
