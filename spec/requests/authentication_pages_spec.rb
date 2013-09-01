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
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end

    end

    describe "with valid information" do

      # this person is a holdling (external) variable on the outside, 
      #   NOT related to the @person or @session or whatever field in controller
      #   (do not be fooled by similarity of names!)
      let(:person) { FactoryGirl.create(:person) }
      before do
        fill_in "Email",    with: person.email.upcase # using upcase verifies that we downcase correctly
        fill_in "Password", with: person.password
        click_button "Sign in"                        # capybara? click_button method?
      end

      # shift to a home page for the person page with title the person's name and with links Profile & Sign out
      it { should have_title(person.name) } # capybara? have_title method?
      it { should have_link('Profile',     href: person_path(person)) } # capybara have_link method
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }         # as we are already signed in

    end

  end

end
