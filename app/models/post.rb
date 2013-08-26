# Posts -- Associated with Talks
# 
# Made by a user with respect to a talk
# 
# Starting point for Tweets
# 
# == Fields
# 1. person_id -- integer, mandatory
# 1. talk_id -- integer, mandatory
# 1. post_type -- string, one of 'join', 'leave', 'comment', also 'create', 'destroy'
# * create -- makes you either the creator or a co-creator
# * destroy -- makes eliminates a creator, when last creator is destory, talk is de-activated?
# 1. comment -- text, text of post
# 
class Post < ActiveRecord::Base
  validates :person_id, presence: true
  validates :talk_id, presence: true
  validates :post_type, presence: true

  # validates_format_of :post_type, :with => /\A(create|destroy|join|leave|comment)\z/
  validates_inclusion_of :post_type, 
    :in => [ 'create', 'destroy', 'join', 'leave', 'comment' ],
    :message => "Invalid table name"
  
  belongs_to :person
  belongs_to :talk
  has_many :attachments, as: :attachable
end
