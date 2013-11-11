require 'spec_helper'

describe "talks/new" do
  
  subject { page }        ## what, exactly, does this do? sets 'it', I think

  let(:page_title) { 'New Talk' }
  let(:heading) { 'New Talk' } 
  let(:person) { FactoryGirl.create(:person) }
  let(:talk) { FactoryGirl.create(:talk, :person_id => person.id.to_s) }

  before do 
    sign_in person
    visit new_person_talk_path(person.id)
  end

  it "renders new talk form" do

    save_and_open_page

    # assert_select doesn't work here

    # tried a lot of variations on form[action=new_person_talk_path(person.id)], none worked,
    #   -- even tho the new_person_talk_path(person.id) was clearly visible in the form
    #   -- tried quoting the path, using ~=, using have_link matcher, ...
    #   -- would be nice to verify we have hit the exact right page...

    should have_selector("form[method=post]")
    should have_selector("input#talk_summary[name=\"talk[summary]\"]")
    should have_selector("textarea#talk_description[name=\"talk[description]\"]")

  end

end
