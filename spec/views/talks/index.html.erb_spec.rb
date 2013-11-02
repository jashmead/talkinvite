require 'spec_helper'

describe "talks/index" do

  subject { page }

  before(:each) do
    assign(:talks, [
      stub_model(Talk,
        :summary => "Summary1",
        :description => "MyText",
        :talk_status => 'active'
      ),
      stub_model(Talk,
        :summary => "Summary2",
        :description => "MyText",
        :talk_status => 'active'
      ),
      stub_model(Talk,
        :summary => "Summary3",
        :description => "MyText",
        :talk_status => 'new'
      ),
      stub_model(Talk,
        :summary => "Summary4",
        :description => "MyText",
        :talk_status => 'done'
      ),
      stub_model(Talk,
        :summary => "Summary5",
        :description => "MyText",
        :talk_status => 'cancelled'
      )
    ])
  end

  it "renders a list of talks" do
    render
    assert_select "tr > td", :text => "Summary1".to_s, :count => 1
    assert_select "tr > td", :text => "Summary2".to_s, :count => 1
  end
end
