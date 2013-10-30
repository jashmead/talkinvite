# specs for stories involving talks (main starting point)

require 'spec_helper'

describe 'talks' do

  subject { page }

  # you can get to a talk by starting it
  describe 'new talk' do

    # trying to get core functionality working, even when we are not signed in!
    describe 'when not signed in' do
      pending("they should be allowed to fill in the form, but then get a signin/new account request when they save")
    end

    describe 'when signed in' do
      pending("they should be able to create a new talk")
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
