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
        expect { click_button "Start Talk" }.not_to change(Talk, :count)
      end

      describe "should show error messages" do
        before { click_button "Start Talk" }
        it { 
          # save_and_open_page
          should have_content('error')
        }
      end
    end

  end

end
