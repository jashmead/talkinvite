# this file is part of the documentation for the stories! and therefore the links

# per assertions in https://github.com/rspec/rspec-rails/blob/master/Capybara.md, have moved this file to spec/features
#   does this make any difference?  visit & page were already working & are for most other request files

# 'it' has to be a leaf node?

# if we convert a leaf describe to an 'it', it is suddenly a (passing) test

# it appears that 'save_and_open_page' has to be inside an 'it'
#   -- because launchy is being called via capybara, not directly?
#     -- launchy definitely uses capybara, see the capybara embedded in the tmp url!
#   -- putting in a 'require launchy' doesn't help

require 'spec_helper'

describe 'stories' do

  subject { page }

  describe "start" do

    let(:person) { FactoryGirl.create(:person) }

    describe "for signed-in people" do

      before do
        sign_in person
        visit start_path # home page
      end

      it { 
        # save_and_open_page  ## DDT

        should have_selector('h1', text: "My Talks")
      }

    end

    # currently the tests are for page level tests, overlap with those in spec/views/talks/gottalk_page_spec.rb
    describe "for anonymous" do

      before do
        visit start_path # home page
      end

      it { 
        # save_and_open_page  ## DDT

        should have_title('Search for talks or add one')

        should have_selector('h1', text: "Got Talk?")
      }

    end

  end

  # going by life cycle
  describe "gotta talk" do

    describe "start a talk" do
      # add other conditions as indicated
      describe "set attributes" do
        describe "set summary" do
        end
        describe "set details" do
        end
        describe "set location" do
        end
        describe "set start time and end times" do
        end
      end
      describe "tell everyone about the talk" do
      end
    end

    describe "find a talk" do

      describe "by talk itself" do
      end

      describe "similar to what I have talked about earlier" do
      end

      describe "by tag" do
      end

      describe "nearby" do
      end

      describe "by those I am following" do
      end

      describe "by those who follow me" do
      end

      describe "by trending tweets" do
      end

      describe "in google news" do
      end

      describe "by category" do
        describe "sports" do
        end
        describe "news" do
        end
        describe "entertainment" do
        end
        describe "politics" do
        end
        # go out to google or duckduckgo & pick a news category
        describe "any category" do
        end
      end
    end
  
    describe "join a talk" do
    end

  end

  # midlife crisis tests
  describe 'life of talk' do

    # change summary, details, location, time
    describe 'attributes' do
    end

    describe 'membership' do
      describe 'join' do
      end
      describe 'leave' do
      end
    end

    # CRUD tests here
    describe 'comment' do
    end

    # CRUD tests here, by modalities
    describe 'notification' do
    end

    # CRUD tests here
    describe 'message' do
    end
  end

  describe 'end of talk' do
  end

  describe 'other stories' do
  end

end
