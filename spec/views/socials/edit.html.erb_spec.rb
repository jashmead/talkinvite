require 'spec_helper'

describe "socials/edit" do
  before(:each) do
    @social = assign(:social, stub_model(Social,
      :person_id => 1,
      :talk_id => 1,
      :social_type => "MyString",
      :social_text => "MyText"
    ))
  end

  it "renders the edit social form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", social_path(@social), "post" do
      assert_select "input#social_person_id[name=?]", "social[person_id]"
      assert_select "input#social_talk_id[name=?]", "social[talk_id]"
      assert_select "input#social_social_type[name=?]", "social[social_type]"
      assert_select "textarea#social_social_text[name=?]", "social[social_text]"
    end
  end
end
