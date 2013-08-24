require 'spec_helper'

describe "attachments/show" do
  before(:each) do
    @attachment = assign(:attachment, stub_model(Attachment,
      :user_id => 1,
      :name => "Name",
      :description => "MyText",
      :file_type => "File Type",
      :pathname => "Pathname",
      :attachable_type => "Attachable Type",
      :attachable_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/File Type/)
    rendered.should match(/Pathname/)
    rendered.should match(/Attachable Type/)
    rendered.should match(/2/)
  end
end
