## pages covered:
##  usual resources, sign_up

require 'spec_helper'

describe "People pages" do

  subject { page }

  describe "edit" do

    let(:person) { FactoryGirl.create(:person) }
    before do
      sign_in person
      visit edit_person_registration_path(person)
    end

    describe "page" do
      # it { save_and_open_page }
      # TBD:  why is person.name not showing?
      # it { should have_title(person.name) }
    end

    describe "with valid information" do

      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }

      # TBD:  add in tests of descriptions & other new fields
      before do
        fill_in "person_name",             with: new_name
        fill_in "person_email",            with: new_email
        # fill_in "person_password",         with: person.password
        # fill_in "person_password_confirmation", with: person.password
        fill_in "person_current_password",        with: person.password
        click_button "Update"
      end

      it { save_and_open_page } # have to surround the save_and_open_page in an it{}

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-notice') }

      # direct tests of database saves:
      # specify versus 'it'?
      specify { expect(person.reload.name).to  eq new_name }
      specify { expect(person.reload.email).to eq new_email }

    end

  end

end
