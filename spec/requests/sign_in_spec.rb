require 'spec_helper'

describe 'sign in' do
  let(:person) { FactoryGirl.create(:person, name: "X Marks the Spot") }

  subject { page }

  before do 
    sign_in person
    visit home_path
  end

  it {
    save_and_open_page
    expect(page).to have_title("X Marks the Spot".titlecase)
  }

end
