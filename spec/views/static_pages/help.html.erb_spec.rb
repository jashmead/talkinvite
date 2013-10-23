##  require 'spec_helper'
require 'spec_helper'

describe "static_pages/help" do

  before(:each) do
    assign(:helps, [
      stub_model(Faq,
        :question => "How do I do X?",
        :answer => "X may be simply & easily complished by first doing Y"
      ),
      stub_model(Faq,
        :question => "How then do I do Y?",
        :answer => "Why the procedure for doing Y is not other than to first do X!"
      )
    ])
  end

  it "renders a list of helps" do
    render
    # save_and_open_page does not work here:  shows a pure blank page!
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/may be simply/)
    rendered.should_not match(/How then do/)    # this does not have the How Do or How To pattern
  end

  it "goes to the associated faq on click" do
    pending "goes to the associated faq on click"
  end

end
