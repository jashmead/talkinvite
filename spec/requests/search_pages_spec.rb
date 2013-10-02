require 'spec_helper'

describe "search" do

  subject { page }

  describe "search/people" do

    describe "simple search form" do

      let(:person) { FactoryGirl.create(:person) }

      describe "search with one row expected" do

        before do
          visit search_people_path
          fill_in "search_q",    with: person.email
          click_button "Search"
        end

        describe "after click of search" do

          it "should render the found page" do
            expect(page).to have_title('Found people')
          end

        end

      end

    end

  end

end
