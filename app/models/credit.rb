#
# Credits
#
# no search on credits
#
# expect will normally have attachment url's here, at a minimum
#   and tags

=begin
  put in totally honest privacy policy: http://www.itworld.com/print/129778
    -- link from privacy
  ryan, ferne, sara
  jquery, ruby, ruby-on-rails, all of the Gems, jqueryMobile, all of the plugins
    -- link from about
  font-awesome
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.0/css/font-awesome.css" rel="stylesheet">
  duckduckgo
=end

class Credit < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name
  validates :description, presence: true

  # could also use name, however 'updated' works better when changing the credits
  default_scope -> { order('credits.updated_at desc') }
end
