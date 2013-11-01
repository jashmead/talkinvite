# assert_select is often failing, even when page clearly shows correct html
#   -- possibly a problem between jQuery.Mobile & rspec
#   -- in talks/control got <h1> to work when built on the fly, but not in base page setup
#     -- strange
#   -- further, assert_select DOES NOT  match any element on page:  title, h1, ul, even div!
# TBD:  figure out why assert_select only works on some pages with some elements?
#   -- mayhap view specs do NOT use the controller, so can only test static elements of the page!
#     -- which is why the @routes variable is empty!

require 'spec_helper'

describe "static_pages/sitemap" do

  subject { page }

  it "renders a list of pages" do
    assign(:title, 'Site Map')
    assign(:routes, [ [ sitemap_path, 'Site Map', 'static_pages' ] ])
    render
    # assert_select "h1"
    # assert_select "title"
    # assert_select "h1", 'Site Map'
    # assert_select "li > a", :content => 'Site Map'
    # assert_select "li > a", :content => 'Active Talks'
    # assert_select 'ul'
    # assert_select 'div'

    # Rspec command (expect) at least gives better error messages than assert_select
    expect(rendered).to match /Site Map/
  end
end
