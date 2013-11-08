# talks_pages_spec -- tests for talks
#   searches broken out into talk_searches
#   -- tried using test code from Rails 4 in Action, but that just fails, 
#     -- with many errors, see "creating_talks_spec.rb" for fails

require 'spec_helper'

describe "Talk pages" do

  subject { page }

  let(:person) { FactoryGirl.create(:person) }
  before { sign_in person }

  ##  recheck talk creation when we have a new talk path working, 
  ##    these tests are geared to tutorial's microposts & home page
  describe "talk creation" do
    before { visit new_talk_path }

    describe "with invalid information" do
      it "should not create a talk" do
        expect { click_button "Create Talk" }.not_to change(Talk, :count)
      end

      describe "should show error messages" do
        before { click_button "Create Talk" }
        it { 
          # save_and_open_page
          should have_content('error')
        }
      end
    end

    describe "with valid information" do
      before do 
        fill_in 'Summary', with: 'Loren ipsum'
      end
      it "should create a talk" do
        expect { click_button "Create Talk" }.to change(Talk, :count).by(1)
      end
    end

  end

# TBD get talk destroy spec working
  ## bizarrity:  when root_path set to static_pages#splash, this fails, when it is set to home_path it works
  ## recheck delete when we have a edit_talk_path working
  describe "talk destruction" do
    # note;  'let' does *not* work in a before clause, only works inline
    let(:talk) { FactoryGirl.create(:talk, person: person) }

    describe "as correct person" do
      before { visit edit_talk_path(talk) }

      it "should delete a talk" do
        expect { click_link "Delete" }.to change(Talk, :count).by(-1)
      end
    end
  end

  describe "talk edits" do

    # note;  'let' does *not* work in a before clause, only works inline
    let(:talk) { FactoryGirl.create(:talk, person: person, summary: "First summary") }

    describe "as correct person" do
      let(:new_summary)  { "New Summary" }
      before do 
        visit edit_talk_path(talk)
        fill_in "Summary", with: new_summary
        click_button "Update Talk"
      end

      it "summary should have been changed" do
        save_and_open_page
        # specify { expect(talk.reload.summary).to eq new_summary }
      end

    end

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

    describe "as tag cloud" do
    end

  end

  describe "talk comms" do
    
    describe "comments" do
    end

    describe "posts" do
      describe "talkinvite" do 
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

  describe "talk index" do
    before do
      sign_in FactoryGirl.create(:person)
      FactoryGirl.create(:talk, :summary => 'Big Talk', :talk_status => 'active')
      FactoryGirl.create(:talk, :summary => 'No Talk', :talk_status => 'active')
      FactoryGirl.create(:talk, :summary => 'Third Talk', :talk_status => 'new')
      visit talks_path
    end

    # fix 'All', setting to 'My' or whatever (or '1st degree', '2nd degree', ...)
    it { should have_title('List of Talks') }
    it { should have_content('List of Talks') }

    it "should list each talk" do
      # save_and_open_page
      Talk.all.each do |talk|
        expect(page).to have_selector('a', text: talk.summary)
      end
    end
  end

  describe "active talks" do
    before do
      sign_in FactoryGirl.create(:person)
      FactoryGirl.create(:talk, :summary => 'Big Talk', :talk_status => 'active')
      FactoryGirl.create(:talk, :summary => 'No Talk', :talk_status => 'active')
      FactoryGirl.create(:talk, :summary => 'Third Talk', :talk_status => 'new')
      visit active_talks_path
    end

    # fix 'All', setting to 'My' or whatever (or '1st degree', '2nd degree', ...)
    it { should have_title('Current Talks') }
    it { should have_content('Current Talks') }

    it "should list active talks" do
      # save_and_open_page
      # there are ul's in the footer, so have to be a bit more discriminatory in defining our selector:
      expect(page).to have_selector('#talks-active-content li', :count => 2)
      Talk.all.each do |talk|
        # if we are using table rather than list to format people, so li->td
        if talk.talk_status == 'active'
          expect(page).to have_selector('a', text: talk.summary)
        else
          expect(page).not_to have_selector('a', text:talk.summary)
        end
      end
    end
  end

  # see also 'search_pages_spec.rb'
  describe "talk searches" do

    describe "all" do

      # 'let' has to be outside of the before
      let(:talk1) { FactoryGirl.create(:talk, :person, summary: 'Big Talk') }
      let(:talk2) { FactoryGirl.create(:talk, :person) }
      let(:talk3) { FactoryGirl.create(:talk, :person, talk_status: 'done') }
      let(:talk4) { FactoryGirl.create(:talk, :person, talk_status: 'cancelled') }
      let(:talk5) { FactoryGirl.create(:talk, :person, talk_status: 'new') }

      before { 
        visit talks_path
      }

      it "should list all talks" do
        expect(page).to have_content 'Talks'
        # expect(page).to have_content 'Big Talk'
      end

    end

    describe "my talks" do
      before { visit my_talks_talks_path }
    end

  end


end
