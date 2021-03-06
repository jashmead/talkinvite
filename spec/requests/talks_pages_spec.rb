# talks_pages_spec -- tests for talks
#   searches broken out into talk_searches
#   -- tried using test code from Rails 4 in Action, but that just fails, 
#     -- with many errors, see "creating_talks_spec.rb" for fails

require 'spec_helper'

describe "Talk pages" do

  subject { page }

  let(:person) { FactoryGirl.create(:person) }
  let(:talk) { FactoryGirl.create(:talk, :person_id => person.id.to_s) }

  before { sign_in person }

  ##  TBD: recheck talk creation when we have a new talk path working, 
  ##    -- these tests are geared to tutorial's microposts & home page

  # new & create tests:
  describe "talk creation" do
    before do
        visit new_talk_path
    end

    describe "with invalid information" do
      it "should not create a talk" do
        expect { click_button "Save as Draft" }.not_to change(Talk, :count)
      end

      describe "should show error messages" do
        before { click_button "Save as Draft" }
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
        expect { click_button "Save as Draft" }.to change(Talk, :count).by(1)
      end
    end

  end

# TBD:  why are we having sign_in problems with index & search pages?
=begin
  # index tests:
  describe "talk index" do
    before do
      sign_in FactoryGirl.create(:person)
      FactoryGirl.create(:talk, :summary => 'Big Talk', :talk_status => 'active', :person_id => person.id)
      FactoryGirl.create(:talk, :summary => 'No Talk', :talk_status => 'active', :person_id => person.id)
      FactoryGirl.create(:talk, :summary => 'Third Talk', :talk_status => 'draft', :person_id => person.id)
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

  # see also 'search_pages_spec.rb'
  describe "talk searches" do

    describe "all" do

      before do
        sign_in FactoryGirl.create(:person)
        FactoryGirl.create(:talk, :summary => 'Big Talk', :talk_status => 'active', :person_id => person.id)
        FactoryGirl.create(:talk, :summary => 'No Talk', :talk_status => 'active', :person_id => person.id)
        FactoryGirl.create(:talk, :summary => 'Third Talk', :talk_status => 'draft', :person_id => person.id)
        visit search_talks_path
      end

      it "should find talks when there is a match" do
        fill_in "search_q", with: "Third"
        click_button 'Search'
        expect(page).to have_content 'Third'
        expect(page).not_to have_content 'Big Talk'
      end

      it "should find not find talks when there is not a match" do
        fill_in "search_q", with: "ZZTop"
        click_button 'Search'
        expect(page).not_to have_content 'Third'
        expect(page).not_to have_content 'Big Talk'
      end

    end

  end
=end

  describe "talk edits" do

    # note;  'let' does *not* work in a before clause, only works inline
    let(:talk) { FactoryGirl.create(:talk, person: person, summary: "First summary") }

    describe "as correct person" do
      let(:new_summary)  { "New Summary" }
      before do 
        visit edit_talk_path(talk)
        fill_in "Summary", with: new_summary
        click_button "Post"
      end

      it "summary should have been changed" do
        # save_and_open_page
        expect(talk.reload.summary).to eq new_summary
      end

    end

  end

  describe "talk destruction" do
    # note;  'let' does *not* work in a before clause, only works inline
    let(:talk) { FactoryGirl.create(:talk, person: person) }

    describe "as correct person" do
      before { visit edit_talk_path(talk) }

      it "should delete a talk" do
        # save_and_open_page
        expect { click_link "Delete" }.to change(Talk, :count).by(-1)
      end
    end
  end

=begin

  # TBD: get talk posts working
  describe "posts" do
    describe "talkinvite" do 
    end

    describe "emails" do
    end

    describe "tweets" do
    end

    describe "facebook" do
    end

    describe "dm" do 
    end
  end

  # TBD: get talk partner functions working
  describe "talk partners" do

    describe "talk join" do
    end

    describe "talk leave" do
    end

  end

  # TBD: get talk messages working
  describe "messages" do
  end

  # TBD: get talk map, tag cloud, calendar views working
  describe "talk views" do

    describe "as map" do
    end

    describe "as tag cloud" do
    end

  end

=end

end
