# Posts -- Associated with Talks
# 
# Made by a user with respect to a talk
# 
# Starting point for Tweets
# 
# == Fields
# 1. person_id -- integer, mandatory
# 1. talk_id -- integer, mandatory
# 1. post_type -- string, one of 'join', 'leave', 'comment'
# 1. comment -- text, text of post
# 
class Post < ActiveRecord::Base
  belongs_to :person
  belongs_to :talk
  has_many :attachments, as: :attachable
end
