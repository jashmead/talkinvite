## talks/start
##  elements expected:
##    page itself (visit & check title)
##    a search form:
##      search box
##      button saying search

require 'spec_helper'

describe "talks/start" do

  subject { page }        ## what, exactly, does this do? sets 'it', I think

  let(:page_title) { 'Start page for TalkInvite' }
  let(:heading) { 'Got Talk?' }

  describe "renders the start talk form" do
    before { visit "/talks/start" }  ## replace with a 'path', once we have worked that out

    it { should have_title(page_title) }
    it { should have_selector('h1', text: heading) }

  end
end
