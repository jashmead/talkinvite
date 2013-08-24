## get trigger support in for the tags (& in a bit for the files)
class Tag < ActiveRecord::Base
  belongs_to :tagable, polymorphic: true
end
