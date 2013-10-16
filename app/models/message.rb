class Message < ActiveRecord::Base

  ## belongs_to :person
  ## belongs_to :talk

  belongs_to :sender, class_name: "Person"
  belongs_to :receiver, class_name: "Person"

  ## default_scope is not working in the newer/older test
  default_scope -> { order('messages.created_at desc') }

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :message_type, presence: true
  validates :message_text, presence: true

  validates_inclusion_of :message_type, :in => [ 'email', 'dm' ]  # may have others, ultimately

  ## searches:  given person & talk, get all messages in reverse updated_at order

end
