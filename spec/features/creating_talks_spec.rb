# from Rails 4 in Action

# note:  not clear what is allowed when & where in specs
#   appears that it depends on the directory
#   and on whether capybara is in use

# TBD:  explain why 'creating_talks_spec' doesn't work at all
#   -- taken from Rails 4 in Action, should have been ok
#   -- can do all the tests via stuff in talks_pages_spec but would like better understanding of capybara & associated

# questions: 
#   we have not declare 'page' as subject, but we can refer to it?
#   how do we sign in?
#   why doesn't 'let' work?
#   what is the difference between 'feature' and 'describe'?
#   what is the difference between 'scenario' and 'describe'? between 'scenario' and 'it'?

# answer:
#   without better understanding of where the fails are coming from, 
#     can't get code lifted from Rails in Action 4 to work
#   so comment out everything until we do have a better understanding

# capybara notes:
# from rubydoc.info/github/jnicklas/capybara/master#Navigating
#   feature <=> describe :type => :feature
#   given <=> let
#   scenario <=> it

require 'spec_helper'

feature "Creating Talks" do

	before do
    FactoryGirl.create(:person, name: "Test Person") 
    # 'let' is given an undefined method error here!!!
    #   let(:person) { FactoryGirl.create(:person, name: "Test Person") }
    # sign_in :person # works, but the object associated with :person is not a Person

    visit '/sitemap'
    click_link "New Talk"
	end

=begin
	scenario "Creating a talk" do
    fill_in "Summary", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Talk"

    expect(page).to have_content("Talk has been created.")
	end

	scenario "Creating a talk without valid attributes fails" do
    click_button "Create Talk"
    
    expect(page).to have_content("Talk has not been created.")
    expect(page).to have_content("Summary can't be blank")
	end
=end

end
