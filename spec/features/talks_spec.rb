# specs for stories involving talks (main starting point)

require 'spec_helper'

describe 'talks' do

  subject { page }

  # you can get to a talk by starting it
  describe 'new talk' do

    # trying to get core functionality working, even when we are not signed in!
    describe 'when not signed in' do

    end

    describe 'when signed in' do
      let(:person) { FactoryGirl.create(:person) }
    end

    describe 'when signed in as admin' do
      let(:admin) { FactoryGirl.create(:admin) }
    end

  end

  # or by searching for it & then joining it
  describe 'search for talks' do

  end

  # join & leave talks
  describe 'talk membership' do

  end

  # once you are in, you can edit it & comment on it, in general
  describe 'active talks' do

  end

end
