## talks/search
##  elements expected:
##    page itself (visit & check title)
##    a search form:
##      search fields
##      button saying search

require 'spec_helper'

describe "talks/my_talks" do

  subject { page }

  let(:page_title) { 'My Talks' }
  let(:heading) { 'My Talks' } # can't use :heading here?

  describe "renders the search talk form" do
    let(:person) { FactoryGirl.create(:person) }

    before do 
      sign_in person
      visit "/talks/my_talks"
    end 

    it { 
      # save_and_open_page  ## DDT
      should have_title(page_title) 
    }

    it { should have_selector('h1', text: heading) }

    it { should have_button 'Search' }
  end

end
