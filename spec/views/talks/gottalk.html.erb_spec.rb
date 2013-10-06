## talks/search
##  elements expected:
##    page itself (visit & check title)
##    a search form:
##      search fields
##      button saying search

require 'spec_helper'

describe "talks/gottalk" do

  subject { page }       

  let(:page_title) { 'Search for talks or add one' }
  let(:heading) { 'Got Talk?' } # can't use :heading here?

  describe "renders the gottalk talk form" do
    before { visit "/talks/gottalk" }  ## replace with a 'path', once we have worked that out

    ## note each of these tests restarts the whole process, nice
    it { should have_title(page_title) }

    it { should have_selector('h1', text: heading) }

    it { should have_button 'Search' }
  end

end
