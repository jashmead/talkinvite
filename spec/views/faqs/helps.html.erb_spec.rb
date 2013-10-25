require 'spec_helper'

describe "faqs/helps" do

  before(:each) do
    assign(:helps, [
      stub_model(Faq,
        :question => "how do I do X?",  # 'how' present
        :answer => "X may be simply & easily complished by first doing Y",
        :faq_type => 'help'
      ),
      stub_model(Faq,
        :question => "But by what means shall I then do Y?",    
        :answer => "Why the procedure for doing Y is none other than to first do X!",
        :faq_type => 'faq'
      )
    ])
  end

  ## recall that the help index form shows *only* the questions, so look only for them!
  it "renders a list of helps" do
    render
    # save_and_open_page ## save_and_open_page does not work here:  shows a pure blank page! perhaps generally a problem with view specs
    # Run the generator again with the --webrat flag if you want to use webrat matchers
# do not know why the next test is failing:  direct inspection of the screen shows ok
    rendered.should match(/do I do X/)                 
    rendered.should_not match(/how then do I do Y/)   
  end

  it "goes to the associated help on click" do
    pending "goes to the associated help on click"
  end

end
