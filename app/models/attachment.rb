# Attachments -- Polymorphic, point up to basically everything:
# * Talks
# * People
# * Locations
# * Posts
# * Files
# * Tweets -- for images & so forth associated with them
#
# Would have called 'Files', but 'File' is a reserved word to Ruby
# 
# == Fields
# 1. name -- string, mandatory
# 1. description -- text
# 1. file_type -- i.e. image, pdf, word document, whatever
# 1. pathname -- string, present on file system
# 1. attachableable_type -- one of the allowed types
# 1. attachableable_id -- and points to right row in that table
# 
# == Possible Fields
# 1. file_size

## get trigger support in for the attachments
class Attachment < ActiveRecord::Base
  validates :person_id, presence: true
  validates :name, presence: true
  validates :pathname, presence: true
  validates :attachable_type, presence: true
  validates :attachable_id, presence: true

  # validates_format_of :attachable_type, :with => /\A(people|talks|posts|locations|files|tweets)\z/
  validates_inclusion_of :attachable_type, 
    :in => [ 'people', 'talks', 'posts', 'locations', 'files', 'tweets' ],
    :message => "Invalid table name"

  before_save { self.attachable_type.downcase! }

  belongs_to :attachable, polymorphic: true
end
