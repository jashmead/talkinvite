require 'spec_helper'

describe "talks/index" do

  subject { page }

  let(:person) { FactoryGirl.create(:person) }

  let!(:talk0) { FactoryGirl.create(:talk) }
  let!(:talk) { FactoryGirl.create(:talk, :person_id => person.id.to_s, :summary => "Snigglet") }
  let!(:talk1) { FactoryGirl.create(:talk, :person_id => person.id.to_s, :summary => "Snigglet1")}
  let!(:talk2) { FactoryGirl.create(:talk, :person_id => person.id.to_s, :summary => "Snigglet2")}
  let!(:talk3) { FactoryGirl.create(:talk, :person_id => person.id.to_s, :summary => "Snigglet3")}
  let!(:talk4) { FactoryGirl.create(:talk, :person_id => person.id.to_s, :summary => "Snigglet4")}

  before do 
    sign_in person
    visit person_talks_path(person.id)
  end

  it "renders a list of talks" do
    save_and_open_page
    should have_selector('li', /Snigglet1/)
    should have_selector('li', /Snigglet4/)
    should have_link("New Talk")
  end

end
