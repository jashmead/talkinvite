require 'spec_helper'

describe "static_pages/sitemap" do

  subject { page }

  it "renders a list of pages" do
    render
    assert_select "li > a", :content => 'Site Map'
    assert_select "li > a", :content => 'Active Talks'
  end
end
