## people/search
##  elements expected:
##    page itself (visit & check title)
##    a search form:
##      search fields
##      button saying search

require 'spec_helper'

describe "people/search" do

  subject { page }        ## what, exactly, does this do? sets 'it', I think

  let(:page_title) { 'Search for people' }
  let(:heading) { 'Search for people' } # can't use :heading here?

  describe "renders the search person form" do
    before { visit "/people/search" }  ## replace with a 'path', once we have worked that out

    ## note each of these tests restarts the whole process, nice
    it { should have_title(page_title) }

    it { should have_selector('h1', text: heading) }

    ## is 'person_search' correct?
    ## is value => '' correct?
    ## it { should have_field "person_search", :type => :search, :value => '' }

    it { should have_button 'Search' }

  end

end
