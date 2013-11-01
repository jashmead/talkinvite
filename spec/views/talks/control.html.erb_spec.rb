require 'spec_helper'

describe "talks/control" do
  before(:each) do
    @talk = assign(:talk, stub_model(Talk,
      :summary => "Summary1",
      :description => "MyText"
    ))
  end

  it "renders the control talk form" do
    render

    # looks as if we have a jQM versus assert_select war going on here:  
    # assert_select "title", 'Talk Control' # does assert_select only work on the body?
    # assert_select "h1", 'Talk Control' # does assert_select only work on the body?

    # text in the <head> or the <header> areas does not seem to be getting checked:
    # expect(rendered).to match('Talk Control')

    assert_select "h1", 'Summary1'
  end
end

