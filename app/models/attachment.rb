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
# 1. pathname -- string 
# 1. attachableable_type
# 1. attachableable_id
# 
# == Possible Fields
# 1. file_size

## get trigger support in for the attachments
class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
end
