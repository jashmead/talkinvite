# Tweet -- like a post, but more general
# 
# There are lots of tweets we might track that don't point to a specific post
# 
# Basic structure is a stripped down version of the twitter tweet structure, 
# as documented in https://dev.twitter.com/docs/platform-objects/tweets
# 
# Note there are twitter.api requirements on what may be stored about tweets.
# 
# May use streaming tweets as part of the talk buildup.
# 
# Certainly using tweets to announce the talk! Use hashtag & @user talkinvite
#
# There is a ruby gem for twitter; use it!  This stuff is just a placeholder...
# 
# == Fields
# 1. person_id -- integer, of user who generated it, if one of ours
# 1. screen_name -- @user_name, can be outside talkinvite
# 1. content -- actual tweet
# 1. location_id -- location if known
# 
# == Related
# 1. tags -- are the hashtags associated with this
# 1. files -- images & so on
# 
# == Glorious future to come
# 
# Depends on how the system evolves

class Tweet < ActiveRecord::Base
  belongs_to :location
  has_many :tags, as: :tagable
  has_many :attachments, as: :attachable
end
