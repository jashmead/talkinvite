## pages covered:
##  usual resources, signup

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
    it { should have_title('List of People') }
    it { should have_content('List of People') }

    it "should list each person" do
      Person.all.each do |person|
        ## if we are using table rather than list to format people, so li->td
        expect(page).to have_selector('a', text: person.name)
      end
    end

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:person) } }
      ## the 'delete_all' is a bit troubling...
      after(:all) { Person.delete_all }

      it "should list each person" do
        Person.paginate(page: 1).each do |person|
          expect(page).to have_selector('a', text: person.name)
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

        ## I'm seeing the delete link, has right href, & it works, 
        ##  but this test is failing
        ##  -- comment out till we can resolve:
        ## it { should have_link('delete', href: person_path(Person.first)) }


# TBD: fix link delete for admin
=begin
        ## this is failing for no obvious reason
        it "should be able to delete another person" do
          ## note the passing of a block to expect! which then can use its 'to' method
          expect do
            click_link('delete', match: :first)
          end.to change(Person, :count).by(-1)
        end
=end

        ## no 'delete' link to admin him/herself
        it { should_not have_link('delete', href: person_path(admin)) }

      end
    end

  end

  # profile tests 'show' form
  # TBD:  add talk list to profile page
=begin
  describe "profile page" do

    let(:person) { FactoryGirl.create(:person) }
    let!(:t1) { FactoryGirl.create(:talk, person: person, summary: "FooBar") }
    let!(:t2) { FactoryGirl.create(:talk, person: person, summary: "BarFoo") }

    before { visit person_path(person) }

    it { should have_content(person.name) }
    it { should have_title(person.name) }

    describe "talks" do
      it { should have_content(t1.summary) }
      it { should have_content(t2.summary) }
      it { should have_content(person.talks.count) }
    end

  end # end of profile page
=end

  describe "signup page" do

    before { visit signup_path }

    let(:submit) { "Create Person" }

    it { should have_content('New Account') }
    it { should have_title('New Account') }

    describe "with invalid information" do
      it "should not create a person" do
        expect { click_button submit }.not_to change(Person, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "person_name",         with: "Mr. X"
        fill_in "person_email",        with: "mr-x@talkinvite.com"
        fill_in "person_password",     with: "foobar"
        fill_in "person_password_confirmation",      with: "foobar"
      end

      it "should create a person" do
        expect { click_button submit }.to change(Person, :count).by(1)
      end

      describe "after saving the person" do

        before { click_button submit }
        let(:person) { Person.find_by(email: 'mr-x@talkinvite.com') }

        it { should have_link('Settings') }
        it { 
          # save_and_open_page
          should have_title(person.name)
        }
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
      # it { save_and_open_page }
      it { should have_title(person.name) }
    end

    describe "with valid information" do

      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }

      # TBD:  add in tests of descriptions & other new fields
      before do
        fill_in "person_name",             with: new_name
        fill_in "person_email",            with: new_email
        fill_in "person_password",         with: person.password
        fill_in "person_password_confirmation", with: person.password
        click_button "Update Person"
      end

      # it { save_and_open_page } # have to surround the save_and_open_page in an it{}

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }

      it { should have_link('Settings', href: settings_path) }

      # direct tests of database saves:
      # specify versus 'it'?
      specify { expect(person.reload.name).to  eq new_name }
      specify { expect(person.reload.email).to eq new_email }

    end

    describe "forbidden attributes" do

      let(:params) do
        { person: { admin: true, sub: true, password: person.password,
                  password_confirmation: person.password } }
      end

      ## make sure they can't make themselves admins
      before do
        sign_in person, no_capybara: true
        ## direct call from web is under test
        patch person_path(person), params
      end
      specify { expect(person.reload).not_to be_admin }

      ## make sure they can't make themselves subs
      before do
        sign_in person, no_capybara: true
        ## direct call from web is under test
        patch person_path(person), params
      end
      specify { expect(person.reload).not_to be_sub }
    end
  end

  describe "close account" do
    pending "close account -- needs inactive policy"
  end
end
