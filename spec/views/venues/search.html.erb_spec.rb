## venues/search
##  elements expected:
##    page itself (visit & check title)
##    a search form:
##      search fields
##      button saying search

require 'spec_helper'

describe "venues/search" do

  subject { page }        ## what, exactly, does this do? sets 'it', I think

  let(:page_title) { 'Search for Venues' }
  let(:heading) { 'Search for Venues' } # can't use :heading here?

  describe "renders the search venue form" do
    before { visit "/venues/search" }  ## replace with a 'path', once we have worked that out

    ## note each of these tests restarts the whole process, nice
    it { should have_title(page_title) }

    it { should have_selector('h1', text: heading) }

    it { should have_button 'Search' }
    it { should have_button 'Add Venue' }
  end
end
