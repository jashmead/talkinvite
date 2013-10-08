## talks/search
##  elements expected:
##    page itself (visit & check title)
##    a search form:
##      search fields
##      button saying search

require 'spec_helper'

describe "talks/gottalk" do

  subject { page }       

  let(:page_title) { 'Search for talks or add one' }
  let(:heading) { 'Got Talk?' } # can't use :heading here?

  describe "renders the gottalk talk form" do
    
    before { visit '/talks/gottalk' }

    ## note each of these tests restarts the whole process, nice
    it { should have_title(page_title) }

    it { should have_selector('h1', text: heading) }

    it { should have_button 'Search' }

    it { should have_selector('div#hot_talks') }

    it {
      ## save_and_open_page

      should have_button 'Start Talk'
    }
  end

  describe "shows 'hottest' talks" do

    pending(" add eleven talks, verify ten shown, and in updated order ")

  end

  # verify the start talk button actually takes us where we want to go
  describe "we can create a talk from here" do

    # 'let' *must* be before the before {}
    let!(:person) { FactoryGirl.create(:person) }

    # replaced sign_in method in utilities.rb because that was not working
    before { 
      # 'sign_in' *must* be inside the before {}
      sign_in person
      visit '/talks/gottalk'
    }

    it { 
      click_button 'Start Talk'
      should have_title 'New Talk'
    }

  end

end
