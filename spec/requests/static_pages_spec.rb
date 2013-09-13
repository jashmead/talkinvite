require 'spec_helper'

describe "Static Pages" do

  # subject 'page' is reset by capybara's 'visit' function
  subject { page }

  shared_examples_for 'all static pages' do
    it { should have_selector('h1', text: heading) }
    it { should have_title(page_title) }
  end

  describe "About page" do
    before { visit static_pages_about_path }

    let(:page_title) { 'About TalkInvite' }
    let(:heading) { page_title }

    it_should_behave_like('all static pages')
  end

  describe "Contact page" do
    before { visit static_pages_contact_path }

    let(:page_title) { 'Contact Us' }
    let(:heading) { page_title }

    it_should_behave_like('all static pages')
  end

  describe "Credits  page" do
    before { visit static_pages_credits_path }

    let(:page_title) { 'Credits' }
    let(:heading) { page_title }

    it_should_behave_like('all static pages')
  end

  describe "Help page" do
    before { visit static_pages_help_path }

    let(:page_title) { 'Help' }
    let(:heading) { page_title }

    it_should_behave_like('all static pages')
  end

  describe "Menu page" do
    before { visit static_pages_menu_path }

    let(:page_title) { 'All Options for TalkInvite' }
    let(:heading) { page_title }

    it_should_behave_like('all static pages')
  end

  describe "Privacy page" do
    before { visit static_pages_privacy_path }

    let(:page_title) { 'Privacy' }
    let(:heading) { page_title }

    it_should_behave_like('all static pages')
  end

  # nested describes produce nested test messages
  describe "Splash page" do
    before { visit static_pages_splash_path }

    let(:page_title) { 'Got Talk?' }
    let(:heading) { page_title }

    it_should_behave_like('all static pages')

    describe "for signed-in people" do

      let(:person) { FactoryGirl.create(:person) }
      before do
        FactoryGirl.create(:talk, person: person, summary: "Lorem ipsum")
        FactoryGirl.create(:talk, person: person, summary: "Dolor sit amet")
        sign_in person
        visit root_path # splash page
      end

      it "should render the person's feed" do
        person.feed.each do |talk|
          ## ##{talk.id} -> # and the talk.id -> <li id="talk.id" > ... </li>
          ## pretty detailed test!
          expect(page).to have_selector("li##{talk.id}", text: talk.summary)
        end
      end
    end

  end

end
