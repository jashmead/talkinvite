# Attachments -- Polymorphic, point up to basically everything:
# * Talks
# * Users
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
  belongs_to :attachable, polymorphic: true
end
