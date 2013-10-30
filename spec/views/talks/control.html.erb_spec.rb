require 'spec_helper'

describe "talks/control" do
  before(:each) do
    @talk = assign(:talk, stub_model(Talk,
      :summary => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the control talk form" do
    render

    # assert_select "title", 'Talk Control' # does assert_select only work on the body?
    assert_select "h1", 'MyString'
  end
end

