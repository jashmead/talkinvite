## basic search tests
require 'spec_helper'

describe "search" do

  subject { page }

  ## DRY model searches here, once we branch out to talks & the rest
  ## can set a few variables here to help out the DRY process

  describe "people" do

    ## let has to go here & not in a 'before' group? apparently so
    let(:person) { FactoryGirl.create(:person) }

    describe "simple search form" do

      before do
        ## and it looks as if visits have to go in a before group
        visit search_people_path
      end

      describe "search with no rows expected" do

        before do
          ## fill_in has to be in 'before' section?
          fill_in "search_q",    with: "ZZTop"
          click_button "Search"
        end

        it "should return to the search page with a message" do
          ## would like a more accurate response, specifically that it was an error message we looked at
          # save_and_open_page # courtesy of launchy; opens current page; sans formatting, however
          expect(page).to have_content("No matching people found for 'ZZTop'")
          expect(page).to have_title("Search for People")
        end

      end

      describe "search with one row expected" do

        before do
          fill_in "search_q",    with: person.email
          click_button "Search"
        end

        describe "after click of search" do

          it "should render the found page" do
            ## save_and_open_page
            expect(page).to have_content('Found one matching person')
            expect(page).to have_title("People")
            expect(page).to_not have_title("Search for People")
          end

        end

      end

      describe "search with two rows expected" do

        before do
          FactoryGirl.create(:person)
          FactoryGirl.create(:person)
          fill_in "search_q",    with: "Person"
          click_button "Search"
        end

        describe "after click of search" do

          it "should render the found page" do
            expect(page).to have_content('Found 2 matching people')
            expect(page).to have_title("People")
            expect(page).to_not have_title("Search for People")
          end

        end

      end

    end

  end

  ## there are probably some DRY opportunities here, especially once we add 'start' to the mix
  describe "talks" do

    ## let has to go here & not in a 'before' group? apparently so
    let(:talk) { FactoryGirl.create(:talk) } 

    # how to loop thru multiple possible visit paths, i.e. search_talks_path and start_talks_path

    describe "simple search form" do

      before do
        ## and it looks as if visits have to go in a before group
        visit search_talks_path
      end

      describe "search with no rows expected" do

        before do
          ## fill_in has to be in 'before' section?
          fill_in "search_q",    with: "ZZTop"
          click_button "Search"
        end

        it "should return to the search page with a message" do
          ## would like a more accurate response, specifically that it was an error message we looked at
          expect(page).to have_content("No matching talks found for 'ZZTop'")
          expect(page).to have_title("Search for Talks")
        end

      end

      describe "search with one row expected" do

        before do
          fill_in "search_q",    with: talk.summary
          click_button "Search"
        end

        describe "after click of search" do

          it "should render the found page" do
            expect(page).to have_content('Found one matching talk')
            expect(page).to have_title("Talk")
            expect(page).to_not have_title("Search for Talks")
          end

        end

      end

      describe "search with two rows expected" do

        before do
          FactoryGirl.create(:talk)
          FactoryGirl.create(:talk)
          fill_in "search_q",    with: "About"
          click_button "Search"
        end

        describe "after click of search" do

          it "should render the found page" do
            expect(page).to have_content('Found 2 matching talks')
            expect(page).to have_title("Talks")
            expect(page).to_not have_title("Search for Talks")
          end

        end

      end

    end # simple search form

  end # talks

  ## there are probably some DRY opportunities here, especially once we add 'start' to the mix
  describe "venues" do

    ## let has to go here & not in a 'before' group? apparently so
    let(:venue) { FactoryGirl.create(:venue) } 

    # how to loop thru multiple possible visit paths, i.e. search_venues_path and start_venues_path

    describe "simple search form" do

      before do
        ## and it looks as if visits have to go in a before group
        visit search_venues_path
      end

      describe "search with no rows expected" do

        before do
          ## fill_in has to be in 'before' section?
          fill_in "search_q",    with: "ZZTop"
          click_button "Search"
        end

        it "should return to the search page with a message" do
          ## would like a more accurate response, specifically that it was an error message we looked at
          expect(page).to have_content("No matching venues found for 'ZZTop'")
          expect(page).to have_title("Search for Venues")
        end

      end

      describe "search with one row expected" do

        before do
          fill_in "search_q",    with: venue.name
          click_button "Search"
        end

        describe "after click of search" do

          it "should render the found page" do
            expect(page).to have_content('Found one matching venue')
            expect(page).to have_title("Venue")
            expect(page).to_not have_title("Search for Venues")
          end

        end

      end

      describe "search with two rows expected" do

        before do
          FactoryGirl.create(:venue, name: 'Cup of Hope')
          FactoryGirl.create(:venue, name: 'Coffee Of Doom')
          FactoryGirl.create(:venue, name: 'You say Coffee, I say industrial strength sludge')
          FactoryGirl.create(:venue, name: 'Bookshop')
          FactoryGirl.create(:venue, name: 'Street Corner')
          fill_in "search_q",    with: "Coffee"
          click_button "Search"
        end

        describe "after click of search" do

          it "should render the found page" do
            expect(page).to have_content('Found 2 matching venues')
            expect(page).to have_title("Venues")
            expect(page).to_not have_title("Search for Venues")
          end

        end

      end

    end # simple search form

  end # venues

end # searches
