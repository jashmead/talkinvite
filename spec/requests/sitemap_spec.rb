# annoyingly enough, we can't use the 'expect(page)' construct except inside an 'it' block
# this page ensures that all key pages are visited at least once, which is good

require 'spec_helper'

# spec to check out sitemap

describe "sitemap" do

  subject { page }

  let(:simple_list) { [ "About", "Current Talks", "Contact", "Credits", 
      "Frequently Asked Questions", "Help", 
      "List of Talks", 
      "Search for Talks"
    ] }

  let(:signedin_list) { [ "Home", "My Talks", 
    "Settings", 
    "List of People", 
    "Search for People" ] }

  let(:admin_list) { [ "New Credit", "New FAQ", "New Help" ] }

  before { visit sitemap_path }

  it "should list itself" do
    # before { click_link 'Site Map' }
    expect(page).to have_title("Site Map")
  end

  describe "check common pages" do

    # apparently the "each" construct only works inside an 'it' block
    it "should list each page" do

      simple_list.each do |title|

        # can't use a 2nd 'it' inside here, but do not need to?
        visit sitemap_path
        click_link title
        expect(page).to have_title(title)

      end

    end

    it "should not list each signed in pages when we are not signed in" do

      visit sitemap_path

      signedin_list.each do |title|

        expect(page).not_to have_title(title)

      end

    end

  end

  describe "signed in pages" do

    before do
      sign_in FactoryGirl.create(:person)
    end

    it "should each be listed" do

      signedin_list.each do |title|

        # can't use a 2nd 'it' inside here, but do not need to?
        visit sitemap_path
        click_link title
        save_and_open_page
        expect(page).to have_title(title)

      end

    end

  end

  describe "admin pages" do

    before do
      sign_in FactoryGirl.create(:admin)
    end

    it "list admin pages" do

      admin_list.each do |title|

        visit sitemap_path
        click_link title
        expect(page).to have_title(title)

      end

    end

  end

end
