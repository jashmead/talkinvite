class Relationship < ActiveRecord::Base
  belongs_to :from_person, class_name: "Person", foreign_key: 'from_id'
  belongs_to :to_person, class_name: "Person", foreign_key: 'to_id'
end
