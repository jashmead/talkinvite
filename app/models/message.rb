# Messages
#
# search should in general be only of messages from or two the current account
#   should look for stuff associated with the from & to people
#
# messages include emails & dm's, see message type for more
#
# fields to come:
# 1. received_at -- used to monitor delivery

class Message < ActiveRecord::Base

  ## belongs_to :person
  ## belongs_to :talk
  # talkinvite is the default, post is for posts, there will be others
  MESSAGE_TYPES = [ 'talkinvite', 'post' ]

  belongs_to :sender, inverse_of: :messages, class_name: "Person"
  belongs_to :receiver, inverse_of: :messages, class_name: "Person"

  # Note:  we are *not* using belongs_to :talk here;
  #   -- having two paths from people to messages (direct & via talks) seems to confuse RoR

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :message_type, presence: true
  validates :message_text, presence: true

  validates_inclusion_of :message_type, :in => MESSAGE_TYPES            # may have others, ultimately
  validates_inclusion_of :service_type, :in => Service::SERVICE_TYPES

  ## default_scope is not working in the newer/older test
  default_scope -> { order('messages.created_at desc') }

  ## searches:  given person & talk, get all messages in reverse updated_at order

  # is talks_by_person needed?
  def self.messages_by_person( person ) 
    # RoR probably knows to use 'id' when called with 'person', experiment later
    if ! person
      person = Person.anonymous
    end
    self.where('sender_id = ? or receiver_id = ?', person.id, person.id)
  end

end
