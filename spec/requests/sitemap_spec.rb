# annoyingly enough, we can't use the 'expect(page)' construct except inside an 'it' block
# this page ensures that all key pages are visited at least once, which is good

# note: each 'it' is counted as a single example in the report
# note: 'it' has to be 'leaf' node; describe can be anywhere
#  -- ruby code seems to work (generally) inside 'it', but not inside 'describe'
#  -- therefore correct hierarchy is describe, describe, it { ruby code }

require 'spec_helper'

# spec to check out sitemap

describe "sitemap" do

  subject { page }

# TBD:  figure out why List of Talks & Current Talks are not working:  looks like authentication issues
  let(:simple_list) { [ 
    "About", 
    "Contact", 
    "Credits", 
    "FAQs", 
    "List of Help",
    "Search for Talks"
  ] }

  # profile, settings, home not tested here because the title is supposed to be person.name, need to work up more code to check
  let(:signedin_list) { [ 
    # "Home", 
    "My Messages",
    "Create Talk",
    "Search for People"
  ] }

  let(:not_signedin_list) { [
    "Sign In",
    "New Account",
    "Reset Password"
  ] }

  let(:admin_list) { [ "New Credit", "New FAQ", "New Help" ] }

  before { visit sitemap_path }

  it "should list itself" do
    # before { click_link 'Site Map' }
    expect(page).to have_title("Site Map")
  end

  describe "check common pages" do

    it "should list each common page" do

      # apparently the "each" construct only works *inside* an 'it' block
      simple_list.each do |title|

        # can't nest 'it', but don't need to
        visit sitemap_path
        # save_and_open_page
        click_link title
        # save_and_open_page
        expect(page).to have_title(title)

      end

    end

    it "but should not list signed in pages when we are not signed in" do

      visit sitemap_path
      signedin_list.each do |title|
        expect(page).not_to have_title(title)
      end

    end

  end

  describe "signed in pages" do

    before do
      sign_in FactoryGirl.create(:person, :name => 'J. Random User', :email => 'jru@talkinvite.com', :description => "What? Me Worry?")
    end

    
    it "check profile page" do

      visit sitemap_path
      click_link 'Profile'

      # save_and_open_page

      # TBD:  why doesn't person.name work here?
      # expect(page).to have_title(person.name)
      expect(page).to have_title('J. Random User')

      expect(page).to have_selector('h1', 'J. Random User')
      expect(page).to have_text(/Worry/)
      expect(page).not_to have_text(/jru@talkinvite.com/)

    end

    it "check settings page" do

      visit sitemap_path
      click_link 'Settings'

      # save_and_open_page
      expect(page).to have_title('J. Random User')
      expect(page).to have_selector('h1', 'J. Random User')
      expect(page).to have_text(/Worry/)

      # TBD:  find out why 'have_text' doesn't see the email; save_and_open_page shows it is on the page
      # expect(page).to have_text(/jru@talkinvite.com/)

    end

    it "check home page" do

      visit sitemap_path
      click_link 'Home'

      # save_and_open_page
      expect(page).to have_title('J. Random User')
      expect(page).to have_selector('h1', 'J. Random User')
      # we do not print the description in the home page

    end

    it "check change password page" do

      visit sitemap_path
      click_link 'Change Password'

      # save_and_open_page
      expect(page).to have_title('Password 4 J. Random User')
      expect(page).to have_selector('h1', 'J. Random User')

    end

    it "when signed in, should also see pages that are only for those signed in" do

      signedin_list.each do |title|

        # can't use a 2nd 'it' inside here, but do not need to?
        visit sitemap_path
        click_link title
        # save_and_open_page
        expect(page).to have_title(title)

      end

    end

    it "but should not list not signed in pages when we are signed in" do

      visit sitemap_path

      not_signedin_list.each do |title|

        expect(page).not_to have_title(title)

      end

    end

  end

  describe "admin pages" do

    before do
      sign_in FactoryGirl.create(:admin)
    end

    it "only admins should see admin pages" do

      admin_list.each do |title|

        visit sitemap_path
        click_link title
        expect(page).to have_title(title)

      end

    end

  end

end
