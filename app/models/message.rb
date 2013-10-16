class Message < ActiveRecord::Base

  belongs_to :sender, class_name: "Person"
  belongs_to :receiver, class_name: "Person"

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates_inclusion_of :message_type, :in => [ 'email', 'dm' ]

end
