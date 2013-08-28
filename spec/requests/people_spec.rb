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

    let(:submit) { "Create my account" }

    it { should have_content('Sign up') }
    it { should have_title('Sign up') }

    describe "with invalid information" do
      it "should not create a person" do
        expect { click_button submit }.not_to change(Person, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example Person"
        fill_in "Email",        with: "person@talkinvite.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
        # fill_in "Person_type",  with: "reg"
      end

      it "should create a user" do
        expect { click_button submit }.to change(Person, :count).by(1)
      end
    end
  end

end
