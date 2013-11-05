require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign In') }
    it { should have_title('Sign In') }

  end

  describe "signin" do
    before { visit signin_path }

    # test with no information:
    describe "with invalid information" do
      # click the sign in button (without having entered anything)
      before { click_button "Sign In" }

      it { should have_title('Sign In') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    end

## TBD: have to fix up authentication when we get to that point
=begin
    describe "with valid information" do

      let(:person) { FactoryGirl.create(:person) }
      before { sign_in person }

      it { should have_title(person.name) }
      it { should have_link('People',     href: people_path) }
      it { should have_link('Profile',     href: person_path(person)) }
      it { should have_link('Settings',     href: edit_person_path(person)) }
      it { should have_link('Sign Out',    href: signout_path) }
      it { should_not have_link('Sign In', href: signin_path) }

      describe "followed by signout" do
        before { click_link 'Sign Out' }
        it { should have_link 'Sign In' }
      end

    end
=end

  end

  describe "authorization" do

    describe "for non-signed-in people" do

      let(:person) { FactoryGirl.create(:person) }

      it { should_not have_link('Sign Out') }
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
          fill_in "session_email",    with: person.email
          fill_in "session_password", with: person.password
          click_button "Sign In"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit profile')
          end

## TBD: have to fix store location at the same time
=begin
          describe "when signing in again" do

            before do
              delete signout_path   ## why?
              visit signin_path
              fill_in "session_email",    with: person.email
              fill_in "session_password", with: person.password
              click_button "Sign In"
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
          it { should have_title('Sign In') }
        end

        describe "submitting to the update action" do
          # use patch to test the underlying (no template) 'update' action
          before { patch person_path(person) }
          # patch gives (somehow:  more r-o-r magic) direct access to the 'response' object, which we check:
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the people index" do
          before { visit people_path }
          it { should have_title('Sign In') }
        end

      end # non-signed in, people controller

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
