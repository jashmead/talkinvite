require 'spec_helper'

describe "People pages" do

  subject { page }

  ## later restrict this to those with a positive relationship to current person
  describe "index" do
    before do
      sign_in FactoryGirl.create(:person)
      FactoryGirl.create(:person, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:person, name: "Ben", email: "ben@example.com")
      visit people_path
    end

    # fix 'All', setting to 'My' or whatever (or '1st degree', '2nd degree', ...)
    it { should have_title('All people') }
    it { should have_content('All people') }

    it "should list each person" do
      Person.all.each do |person|
        ## if we are using table rather than list to format people, so li->td
        expect(page).to have_selector('li', text: person.name)
      end
    end

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:person) } }
      ## the 'delete_all' is a bit troubling...
      after(:all) { Person.delete_all }

      # it { should have_selector('div', class: 'pagination') }
      it { should have_selector('div.pagination') }
  
      it "should list each person" do
        Person.paginate(page: 1).each do |person|
          expect(page).to have_selector('li', text: person.name)
        end
      end
    end

    describe "delete links" do

      ## generic people should not see 'delete' links 
      it { should_not have_link('delete') }

      describe "as an admin person" do

        ## but now build an admin using FactoryGirl's admin method
        ## how does 'admin' know to go to person?  ah, FactoryGirl sees only one 'admin' method present
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit people_path
        end

        it { should have_link('delete', href: person_path(Person.first)) }
        it "should be able to delete another person" do
          ## note the passing of a block to expect! which then can use its 'to' method
          expect do
            click_link('delete', match: :first)
          end.to change(Person, :count).by(-1)
        end

        ## no 'delete' link to admin him/herself
        it { should_not have_link('delete', href: person_path(admin)) }

      end
    end

  end

  # profile tests 'show' form
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
      end

      it "should create a person" do
        expect { click_button submit }.to change(Person, :count).by(1)
      end

      describe "after saving the person" do

        before { click_button submit }
        let(:person) { Person.find_by(email: 'person@talkinvite.com') }

        it { should have_link('Sign out') }
        it { should have_title(person.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }

      end

    end

  end

  describe "edit" do
    let(:person) { FactoryGirl.create(:person) }
    before do
      sign_in person
      visit edit_person_path(person)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit profile") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do

      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: person.password
        fill_in "Confirm Password", with: person.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }

      # direct tests of database saves:
      # specify versus 'it'?
      specify { expect(person.reload.name).to  eq new_name }
      specify { expect(person.reload.email).to eq new_email }
    end

    describe "forbidden attributes" do
      let(:params) do
        { person: { admin: true, password: person.password,
                  password_confirmation: person.password } }
      end
      before do
        sign_in person, no_capybara: true
        ## direct call from web is under test
        patch person_path(person), params
      end
      specify { expect(person.reload).not_to be_admin }
    end

  end

end
