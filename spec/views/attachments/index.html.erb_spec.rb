require 'spec_helper'

describe "attachments/index" do
  before(:each) do
    assign(:attachments, [
      stub_model(Attachment,
        :name => "Name",
        :description => "MyText",
        :attachment_type => "Attachment Type",
        :attachable_type => "Attachable Type",
        :attachable_id => 1,
        :file_path => "File Path"
      ),
      stub_model(Attachment,
        :name => "Name",
        :description => "MyText",
        :attachment_type => "Attachment Type",
        :attachable_type => "Attachable Type",
        :attachable_id => 1,
        :file_path => "File Path"
      )
    ])
  end

  it "renders a list of attachments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Attachment Type".to_s, :count => 2
    assert_select "tr>td", :text => "Attachable Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "File Path".to_s, :count => 2
  end
end
