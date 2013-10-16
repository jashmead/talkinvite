# Ads
#
# Fields are:
# 1. name -- summary
# 1. description -- text, what are we doing with this
# 1. internal_flag -- boolean, true if ours
# 1. content -- text, what is shown
# 1. strategy -- text, when & where shown
# 1. source -- text, who asked for this
# 1. stats -- text, summary of how much the ads is clicked on, & so on
#
# there is no creator_id, for simplicity, can include in source
#
# the text fields are expected to be json
#
# ads currently apply to talks, notifications, comments, messages, 
# -- may extend in future
#

class Ad < ActiveRecord::Base

  validates :name, presence: true

  validates :content, presence: true  # i.e. image

  validates :source, presence: true  # i.e. image

  validates :strategy, presence: true

end


