## verify links page by page
##  go to each page, make sure it has the links it should have
##  then, follow each link, make sure it is going to the correct target page
##  basically, checks the skeleton of the web site
##  lots & lots of visit_page here
##  search pages are called tables/search
##  first cut, do a visit page on each main page, then check that it has the right id
##    note many routes will not be exercised by this; that is ok for now
##    eventually we should hit every route routes.rb (see "rake routes" for list)

require 'spec_helper'

describe 'links' do

end
