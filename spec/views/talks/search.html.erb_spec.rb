## talks/search
##  elements expected:
##    page itself (visit & check title)
##    a search form:
##      search fields
##      button saying search

require 'spec_helper'

describe "talks/search" do

  subject { page }        ## what, exactly, does this do? sets 'it', I think

  let(:page_title) { 'Search for Talks' }
  let(:heading) { 'Search for Talks' } # can't use :heading here?
  let(:person) { FactoryGirl.create(:person) }
  let(:talk) { FactoryGirl.create(:talk, :person_id => person.id.to_s) }

  describe "renders the search talk form" do
    before { visit search_talks_path }

    ## note each of these tests restarts the whole process, nice
    it { should have_title(page_title) }

    it { should have_selector('h1', text: heading) }

    # TBD:  Search & New Talk button both present, but only New Talk seen?
    # it { should have_button 'New Talk' }
    it { should have_button 'Search' }
  end

end
