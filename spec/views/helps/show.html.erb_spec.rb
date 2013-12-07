require 'spec_helper'

describe "helps/show" do
  before(:each) do
    @help = assign(:help, stub_model(Help,
      :name => "MyName",
      :title => "Help Title",
      :description => "MyDescription",
      :help_type => "page"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyName/)
    rendered.should match(/Help Title/)
    rendered.should match(/MyDescription/)
    rendered.should match(/page/)
  end
end

