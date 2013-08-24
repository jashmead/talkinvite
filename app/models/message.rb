# Messages

# User to User communication, with reference to a talk

# Fields:
# 1.  from_person_id
# 1.  to_person_id
# 1.  talk_id
# 1.  message_type
# 1.  content

# Known problems:
# 1.  Scaffold tests in spec/controllers/messages_controller_spec.rb fail completely
# 2.  We have no confidence that the table itself or the model are setup correctly
# 3.  We don't know how to access

# Fortunately:
# 1.  This is the lowest priority bit in the MVP, after tweets & maps

class Message < ActiveRecord::Base
end
