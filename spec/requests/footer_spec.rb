# annoyingly enough, we can't use the 'expect(page)' construct except inside an 'it' block
# this page ensures that all key pages are visited at least once, which is good

# note: each 'it' is counted as a single example in the report

# note: 'it' has to be 'leaf' node; describe can be anywhere
#  -- ruby code seems to work (generally) inside 'it', but not inside 'describe'
#  -- therefore correct hierarchy is describe, describe, it { ruby code }
#
# note: with shift to devise, rules have changed; now best to sign_in at the top of a set of loops

require 'spec_helper'

# spec to check out sitemap

describe "footers" do

  subject { page }

  # only pages here, not dialogs

  # TBD:  figure out how to multi-dimensional hashes/arrays here; then can DRY
  let(:help_page_list) { [
    "Credits",
    "FAQs", 
    "List of Help",
    "New Credit",
    "New FAQ",
    "New Help"
  ] }
  let(:help_footer_list) { [ 'Home', 'Helps', 'Credits', 'Faqs' ] }

  let(:home_page_list) { [ "Home" ] }
  let(:home_footer_list) { [ 'Site Map', 'New Talk', 'Talks', 'Sign Out' ] }

  # TBD:  get people_page_list in sync with feet_for_people
  let(:people_page_list) { [ 
    "Start Talk",
    # "My Messages",
    # "Search for People",
    "Search for Talks",
    "Settings"
  ] }
  # TBD:  fix people_footer to work for home page as well (no 'home' on home page)
  # let(:people_footer_list) { [ 'Home', 'New Talk', 'Talks', 'Sign Out' ] }
  let(:people_footer_list) { [ 'New Talk', 'Talks', 'Sign Out' ] }

  let(:static_page_list) { [ 
    "About", 
    "Contact", 
    "Site Map"
  ] }
  let(:static_footer_list) { [ 'Home', 'About', 'Contact', 'Privacy' ] }

=begin
# note:  have tried every variation on let & before I can think of to set @page_list & @footer_list variables
#   -- none worked, in general they left the variabiles as nil

  @page_list = {
    'help' => [ "Credits", "Frequently Asked Questions", "Help", "New Credit", "New FAQ", "New Help" ],
    'home' => [ "Home" ],
    # TBD:  why isn't "My Messages" working?
    # 'people' => [ "Start Talk", "My Messages", "Search for People", "Search for Talks", "Settings" ],
    'people' => [ "Start Talk", "Search for People", "Search for Talks", "Settings" ],
    'static' => [ "About", "Contact", "Site Map" ]
  }

  @footer_list = {
    'help' => [ 'Home', 'Helps', 'Credits', 'Faqs' ],
    'home' => [ 'Site Map', 'New Talk', 'Talks', 'Sign Out' ],
    'people' => [ 'Home', 'New Talk', 'Talks', 'Sign Out' ],
    'static' => [ 'Home', 'About', 'Contact', 'Privacy' ]
  }

  describe "check footers" do
    # apparently the "each" construct only works *inside* an 'it' block
    @page_list.each do | page_type, page_list_for_type |
      page_list_for_type.each do |title|
        footer_list[page_type].each | footer_title | do
          # because the footer element can be 'Sign Out', sign in (as admin) before *each* test
          sign_in FactoryGirl.create(:admin)
          visit sitemap_path
          click_link title
          within('.footer') do
              should have_selector('a', :text => footer_title)
              click_link footer_title
          end
        end # end of loop thru footer links
      end # end of loop thru pages within a page type
    end # end of loop thru page types
  end # end of check footers

=end

  describe "check sitemap when not signed in" do

    it "if not signed in" do
      [ 'About', 'Contact', 'Privacy' ].each do |footer_title|
        # because the footer element can be 'Sign Out', sign in (as admin) before *each* test
        visit sitemap_path
        click_link title
        within('.footer') do
            should have_selector('a', :text => footer_title)
            click_link footer_title
        end
      end
    end

    # note:  this code will have to be adjusted if we decide to start somewhere else, i.e. 'About'
    it "check 'start' option separate" do
      visit sitemap_path
      within('.footer') do
          should have_selector('a', :text => 'Start')
          click_link 'Start'
          should have_title("Search for Talks")
      end
    end

  end

  describe "check help pages" do
    it "should have help footer" do
      # apparently the "each" construct only works *inside* an 'it' block
      sign_in FactoryGirl.create(:admin)
      help_page_list.each do |title|
        help_footer_list.each do |footer_title|
          # because the footer element can be 'Sign Out', sign in (as admin) before *each* test
          visit sitemap_path
          click_link title
          within('.footer') do
              should have_selector('a', :text => footer_title)
              click_link footer_title
          end
        end
      end
    end
  end

  describe "check home pages" do
    it "should have home footer" do
      # apparently the "each" construct only works *inside* an 'it' block
      sign_in FactoryGirl.create(:admin)
      home_page_list.each do |title|
        home_footer_list.each do |footer_title|
          visit sitemap_path
          click_link title
          within('.footer') do
              should have_selector('a', :text => footer_title)
              click_link footer_title
              # save_and_open_page
          end
        end
      end
    end
  end

# TBD:  get feet_for_people_pages & this back in sync
=begin
  describe "check people pages" do
    it "should have people footer" do
      # apparently the "each" construct only works *inside* an 'it' block
      sign_in FactoryGirl.create(:admin)
      people_page_list.each do |title|
        people_footer_list.each do |footer_title|
          visit sitemap_path
          # save_and_open_page
          click_link title
          within('.footer') do
              # save_and_open_page
              should have_selector('a', :text => footer_title)
              click_link footer_title
          end
        end
      end
    end
  end
=end

  describe "check static pages" do
    it "should have static footer" do
      sign_in FactoryGirl.create(:admin)
      # apparently the "each" construct only works *inside* an 'it' block
      static_page_list.each do |title|
        static_footer_list.each do |footer_title|
          visit sitemap_path
          click_link title
          within('.footer') do
              should have_selector('a', :text => footer_title)
              click_link footer_title
              # save_and_open_page
          end
        end
      end
    end
  end

end
