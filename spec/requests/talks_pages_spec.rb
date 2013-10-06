# talks_pages_spec -- tests for talks
#   searches broken out into talk_searches

require 'spec_helper'

describe "Talk pages" do

  subject { page }

  let(:person) { FactoryGirl.create(:person) }
  before { sign_in person } # why does this work? given that FactoryGirl is creating a new person?

  describe "talk creation" do
    before { visit home_path }

    describe "with invalid information" do
      it "should not create a talk" do
        expect { click_button "Start Talk" }.not_to change(Talk, :count)
      end

      describe "should show error messages" do
        before { click_button "Start Talk" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in 'talk_summary', with: 'Loren ipsum' }
      it "should create a talk" do
        expect { click_button "Start Talk" }.to change(Talk, :count).by(1)
      end
    end

  end

  ## bizarrity:  when root_path set to static_pages#splash, this fails, when it is set to home_path it works
  describe "talk destruction" do
    before { FactoryGirl.create(:talk, person: person) }

    describe "as correct person" do
      before { visit home_path }

      it "should delete a talk" do
        # how do we know there is a talk ready to be deleted?
        # because we just created one 8 lines back! with FactoryGirl(:talk...)
        expect { click_link "Delete" }.to change(Talk, :count).by(-1)
      end
    end
  end

  describe "talk edits" do

  end

  describe "talk members" do

    describe "talk join" do
    end

    describe "talk leave" do
    end

  end

  # as map, calendar, tag cloud, ...
  describe "talk views" do

    describe "as map" do
    end

    describe "as calendar" do
    end

    describe "as tag cloud" do
    end

  end

  describe "talk comms" do
    
    describe "comments" do
    end

    describe "notifications" do
      describe "posts" do 
      end
  
      describe "emails" do
      end

      describe "tweets" do
      end

      describe "facebook" do
      end
    end

    describe "messages" do
    end
  
  end

  # see also 'search_pages_spec.rb'
  describe "talk searches" do

    describe "my talks" do
    end

    describe "nearby" do
    end

    describe "recent" do
    end

    describe "trending" do
    end

    # include sports, fashion, news, politices, tech, & so on
    describe "categories" do
    end
  
  end

  # lists of talks in various formats
  describe "talk lists" do

  end

  # can pick more than one talk in some cases
  describe "talk picks" do

  end

end
