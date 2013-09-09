require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }

  end

  describe "signin" do
    before { visit signin_path }

    # test with no information:
    describe "with invalid information" do
      # click the sign in button (without having entered anything)
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visiting another page" do
        # note this was failing until we correctly instantiated the target page (by changing it to 'Help')
        before { click_link "Help" }
        it { should_not have_selector('div.alert.alert-error') }
      end

    end


    describe "with valid information" do

      let(:person) { FactoryGirl.create(:person) }
      before do
        fill_in "Email",    with: person.email.upcase
        fill_in "Password", with: person.password
        click_button "Sign in"
      end

      it { should have_title(person.name) }
      it { should have_link('Profile',     href: person_path(person)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link 'Sign out' }
        it { should have_link 'Sign in' }
      end

    end


    describe "debug" do

      let(:person) { FactoryGirl.create(:person) }
      before do
        fill_in "Email",    with: person.email.upcase
        fill_in "Password", with: person.password
        click_button "Sign in"
      end

      it { should have_link('Profile',     href: person_path(person)) }
    end

  end

end
