require 'spec_helper'

describe "socials/new" do
  before(:each) do
    assign(:social, stub_model(Social,
      :person_id => 1,
      :talk_id => 1,
      :social_type => "MyString",
      :social_text => "MyText"
    ).as_new_record)
  end

  it "renders new social form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", socials_path, "post" do
      assert_select "input#social_person_id[name=?]", "social[person_id]"
      assert_select "input#social_talk_id[name=?]", "social[talk_id]"
      assert_select "input#social_social_type[name=?]", "social[social_type]"
      assert_select "textarea#social_social_text[name=?]", "social[social_text]"
    end
  end
end
