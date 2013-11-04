# annoyingly enough, we can't use the 'expect(page)' construct except inside an 'it' block
require 'spec_helper'

# spec to check out sitemap

describe "sitemap" do

  subject { page }

  before { visit sitemap_path }

  it "should list itself" do
    # before { click_link 'Site Map' }
    expect(page).to have_title("Site Map")
  end

  describe "help" do

    before { click_link "Help" }

    it "should have a help page" do
      expect(page).to have_title("Helps")
    end

  end

  describe "contact" do

    before { click_link "Contact" }

    it "should have a help page" do
      expect(page).to have_title("Contact")
    end

  end

  describe "signed in pages" do

    before do
      sign_in FactoryGirl.create(:person)
    end

    describe "home" do
      before do
        click_link "Home"
      end

      it "should go to the home page" do
        expect(page).to have_title("Home")
      end

    end

    describe "my talks" do
      before do
        click_link "My Talks"
      end

      it "should go to my talks" do
        expect(page).to have_title("My Talks")
      end

    end

  end

end
