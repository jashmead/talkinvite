require 'spec_helper'

describe "attachments/index" do
  before(:each) do
    assign(:attachments, [
      stub_model(Attachment,
        :person_id => 1,
        :name => "Name",
        :description => "MyText",
        :file_type => "File Type",
        :pathname => "Pathname",
        :attachable_type => "Attachable Type",
        :attachable_id => 2
      ),
      stub_model(Attachment,
        :person_id => 1,
        :name => "Name",
        :description => "MyText",
        :file_type => "File Type",
        :pathname => "Pathname",
        :attachable_type => "Attachable Type",
        :attachable_id => 2
      )
    ])
  end

  it "renders a list of attachments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "File Type".to_s, :count => 2
    assert_select "tr>td", :text => "Pathname".to_s, :count => 2
    assert_select "tr>td", :text => "Attachable Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
