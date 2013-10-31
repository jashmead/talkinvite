##  require 'spec_crediter'
require 'spec_helper'

describe "faqs/credit" do

  # FactoryGirl does not work here, why?
  before(:each) do
    assign(:credit, stub_model(Faq,
        :question => "How do I do X?",  # 'how' present
        :answer => "First do Y",
        :faq_type => 'credit'
      )
    )
  end

  it "renders the credit" do
    render
    # save_and_open_page does not work here:  shows a pure blank page! -- apparently does not work in view specs
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/How do I do/)
    rendered.should match(/First do Y/)  
  end

end
