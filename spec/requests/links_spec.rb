require 'spec_helper'

# links_spec is basically a check on the foreign keys
#   verify that the pages that should have links do
#   verify that all foreign keys show up here, & everything here shows up as a foreign key
# link tests are related to routing tests
#   routing tests are tests "on the inside"
#   link tests are tests "on the outside"

describe 'links' do

  describe 'people' do
    
    describe 'to talks' do
      describe 'as creator' do
      end

      describe 'as member' do
      end
    
      describe 'to comments' do
      end

      describe 'to notifications' do
      end

    end
  
    describe 'to other people' do
      describe 'to messages' do
      end

      describe 'to following' do
      end

      describe 'to followed' do
      end
    end

  end

  describe 'talks' do
    describe 'to people' do
      describe 'to creator' do
      end

      describe 'to members' do
      end
    end

    describe 'to messages' do
    end

    describe 'to comments' do
    end

    describe 'to notifications' do
    end

  end

  # relationships are implicit in the above, so no separate checks here

  # members implicit in the above, so no separate checks here

  # comments implicit in the above, so no separate checks here

  # messages implicit in the above, so no separate checks here

  # notifications implicit in the above, so no sepearate checks here

  # tags are polymorphic
  describe 'tags' do

    describe 'for talks' do
    end

    describe 'for venues' do
    end

  end

  # venues include locations
  describe 'venues' do

    describe 'to people' do
    end

    describe 'to tags' do
    end

    describe 'to maps' do
    end

  end

  describe 'maps' do
    describe 'from venues' do
    end

    describe 'from talks' do
      describe 'direct' do
      end
      describe 'via venue' do
      end
    end

    # find nearby locations for a given one
    describe 'nearby' do
    end
  end

  describe 'calendars' do
    describe 'from talks' do
      # find recent talks
      describe 'recent' do
      end

      describe 'my talks' do
      end
    end

    describe 'from comments' do
    end

    describe 'from notifications' do
    end

    describe 'from messages' do
    end

  end

  describe 'attachments' do
    describe 'for talks' do
    end

    describe 'for people' do
    end

    describe 'for comments' do
    end

    describe 'for notifications' do
    end

    describe 'for messages' do
    end
  end

end
