require 'spec_helper'

describe "People" do
  subject { page }

  describe "profile page" do
    let(:person) { FactoryGirl.create(:person) }

    before { visit person_path(person) }

    it { should have_content(person.name) }
    it { should have_title(person.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title('Sign up') }
  end

end
