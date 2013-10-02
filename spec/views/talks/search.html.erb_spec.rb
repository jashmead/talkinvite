## talks/search
##  elements expected:
##    page itself (visit & check title)
##    a search form:
##      search fields
##      button saying search

require 'spec_helper'

describe "talks/search" do

  subject { page }        ## what, exactly, does this do? sets 'it', I think

  let(:page_title) { 'Search for talks' }
  let(:heading) { 'Search for talks' } # can't use :heading here?

  describe "renders the search talk form" do
    before { visit "/talks/search" }  ## replace with a 'path', once we have worked that out

    ## note each of these tests restarts the whole process, nice
    it { should have_title(page_title) }

    it { should have_selector('h1', text: heading) }

    it { should have_button 'Search' }
  end

end
