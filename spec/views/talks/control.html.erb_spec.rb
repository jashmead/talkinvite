# spec for talk control

require 'spec_helper'

describe "talks/control" do
  
  subject { page }        ## what, exactly, does this do? sets 'it', I think

  let(:page_title) { 'Talk' }
  let(:heading) { 'Talk' } 
  let(:person) { FactoryGirl.create(:person) }
  let(:talk) { FactoryGirl.create(:talk, :person_id => person.id.to_s, :summary => 'Controlled Talk') }

  before do 
    sign_in person
    visit control_talk_path(talk)
  end

  it "renders talk control form" do

    should have_selector("form[method=post]")
    should have_selector("input#talk_summary[name=\"talk[summary]\"]")
    should have_selector("textarea#talk_description[name=\"talk[description]\"]")
    should have_title(talk.summary)

  end

end
