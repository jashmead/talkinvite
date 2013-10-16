require 'spec_helper'

describe "attachments/show" do
  before(:each) do
    @attachment = assign(:attachment, stub_model(Attachment,
      :name => "Name",
      :description => "MyText",
      :attachment_type => "Attachment Type",
      :attachable_type => "Attachable Type",
      :attachable_id => 1,
      :file_path => "File Path"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/Attachment Type/)
    rendered.should match(/Attachable Type/)
    rendered.should match(/1/)
    rendered.should match(/File Path/)
  end
end
