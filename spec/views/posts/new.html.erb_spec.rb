require 'spec_helper'

# TBD:  how to manage nested paths in view specs? and is it worth the trouble?
# page: http://stackoverflow.com/questions/5515725/rspec-view-specs-for-nested-models
=begin
describe "posts/new.html.erb" do
  before(:each) do
    assign(:talk, mock_model(Talk))
  end

  it "renders new post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should contain("Create Post")
  end
end
=end
