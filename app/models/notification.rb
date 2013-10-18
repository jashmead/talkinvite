class Notification < ActiveRecord::Base

  belongs_to :person
  belongs_to :talk

  ## default_scope is not working in the newer/older test
  default_scope -> { order('notifications.created_at desc') }

  validates :person_id, presence: true
  validates :talk_id, presence: true
  validates :note_type, presence: true
  # validates :note_text, presence: true

  validates_inclusion_of :note_type, :in => [ 'announce', 'modify', 'cancel' ]  # may have others, ultimately

  validates_uniqueness_of :person_id, :talk_id

  ## searches:  given person & talk, get all comments in reverse updated_at order

end
