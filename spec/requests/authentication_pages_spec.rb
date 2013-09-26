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
      before { sign_in person }

      it { should have_title(person.name) }
      it { should have_link('People',     href: people_path) }
      it { should have_link('Profile',     href: person_path(person)) }
      it { should have_link('Settings',     href: edit_person_path(person)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link 'Sign out' }
        it { should have_link 'Sign in' }
      end

    end

=begin
    # debug was used to drill in on some test failures
    describe "debug" do

      let(:person) { FactoryGirl.create(:person) }
      before do
        fill_in "Email",    with: person.email.upcase
        fill_in "Password", with: person.password
        click_button "Sign in"
      end

      it { should have_link('Profile',     href: person_path(person)) }
    end
=end

  end

  describe "authorization" do

    describe "for non-signed-in people" do

      let(:person) { FactoryGirl.create(:person) }

      it { should_not have_link('Sign out') }
      it { should_not have_link('Profile') }
      it { should_not have_link('Settings') }

      describe "in the Talk controller" do

        ## should make sure we can't do a 'new' or 'edit' either, both would annoy
        ## expect something similar to this for posts as well
        describe "submitting to the create action" do
          before { post talks_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        # adding in check on edits
        describe "submitting to the update action" do
          before { patch talk_path(FactoryGirl.create(:talk)) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete talk_path(FactoryGirl.create(:talk)) }
          specify { expect(response).to redirect_to(signin_path) }
        end

      end

      describe "when attempting to visit a protected page" do

        before do
          visit edit_person_path(person)
          fill_in "Email",    with: person.email
          fill_in "Password", with: person.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit profile')
          end

## have to fix store location at the same time
## get this working?
=begin
          describe "when signing in again" do

            before do
              delete signout_path   ## why?
              visit signin_path
              fill_in "Email",    with: person.email
              fill_in "Password", with: person.password
              click_button "Sign in"
            end

            it "should render the default (profile) page" do
              expect(page).to have_title(person.name)
            end
          end
=end
        end

      end

      describe "in the People controller" do

        describe "visiting the edit page" do
          before { visit edit_person_path(person) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          # use patch to test the underlying (no template) 'update' action
          before { patch person_path(person) }
          # patch gives (somehow:  more r-o-r magic) direct access to the 'response' object, which we check:
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the people index" do
          before { visit people_path }
          it { should have_title('Sign in') }
        end

        describe "visiting the following page" do
          before { visit following_person_path(person) }
          it { should have_title('Sign in') }
        end

        describe "visiting the followers page" do
          before { visit followers_person_path(person) }
          it { should have_title('Sign in') }
        end

      end # non-signed in, people controller

      ## should we have parallel tests to make sure we are either 
      ##   an admin or own one of the two ends of the relationship?
      describe "in the Relationships controller" do
        describe "submitting to the create action" do
          before { post relationships_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete relationship_path(1) }    # doesn't matter about the '1', just has to be something
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

    end # non-signed in tests

    describe "as wrong person" do
      let(:person) { FactoryGirl.create(:person) }
      let(:wrong_person) { FactoryGirl.create(:person, email: "wrong@example.com") }
      before { sign_in person, no_capybara: true }

      describe "submitting a GET request to the People#edit action" do
        before { get edit_person_path(wrong_person) }
        specify { expect(response.body).not_to match('Edit person') }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the People#update action" do
        before { patch person_path(wrong_person) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end


    describe "as non-admin person" do
      let(:person) { FactoryGirl.create(:person) }
      let(:non_admin) { FactoryGirl.create(:person) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Person#destroy action" do
        before { delete person_path(person) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

  end

end
