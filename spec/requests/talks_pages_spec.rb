require 'spec_helper'

describe "Talk pages" do
  subject { page }

  let(:person) { FactoryGirl.create(:person) }
  before { sign_in person } # why does this work? given that FactoryGirl is creating a new person?

  describe "talk creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create a talk" do
        expect { click_button "Start Talk" }.not_to change(Talk, :count)
      end

      describe "should show error messages" do
        before { click_button "Start Talk" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in 'talk_summary', with: 'Loren ipsum' }
      it "should create a talk" do
        expect { click_button "Start Talk" }.to change(Talk, :count).by(1)
      end
    end

  end

  describe "talk destruction" do
    before { FactoryGirl.create(:talk, person: person) }

    describe "as correct person" do
      before { visit root_path }

      it "should delete a talk" do
        # how do we know there is a talk ready to be deleted?
        # because we just created one 8 lines back! with FactoryGirl(:talk...)
        expect { click_link "Delete" }.to change(Talk, :count).by(-1)
      end
    end
  end

end
