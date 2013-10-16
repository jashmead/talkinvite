require 'spec_helper'

describe "ads/new" do
  before(:each) do
    assign(:ad, stub_model(Ad,
      :name => "",
      :description => "MyText",
      :internal_flag => false,
      :content => "MyText",
      :source => "MyText",
      :strategy => "MyText",
      :stats => "MyText"
    ).as_new_record)
  end

  it "renders new ad form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", ads_path, "post" do
      assert_select "input#ad_name[name=?]", "ad[name]"
      assert_select "textarea#ad_description[name=?]", "ad[description]"
      assert_select "input#ad_internal_flag[name=?]", "ad[internal_flag]"
      assert_select "textarea#ad_content[name=?]", "ad[content]"
      assert_select "textarea#ad_source[name=?]", "ad[source]"
      assert_select "textarea#ad_strategy[name=?]", "ad[strategy]"
      assert_select "textarea#ad_stats[name=?]", "ad[stats]"
    end
  end
end
