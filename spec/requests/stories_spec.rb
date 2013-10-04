require 'spec_helper'

# this is actually the documentation for the stories! and therefore the links

# 'it' has to be a leaf node?

# if we convert a leaf describe to an 'it', it is suddenly a (passing) test

describe 'stories' do

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
