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

    let(:page_title) { 'About' }
    let(:heading) { page_title }

    it_should_behave_like('all static pages')
  end

  describe "Contact page" do
    before { visit static_pages_contact_path }

    let(:page_title) { 'Contact Us' }
    let(:heading) { page_title }

    it_should_behave_like('all static pages')
  end

  describe "Privacy page" do
    before { visit static_pages_privacy_path }

    let(:page_title) { 'Privacy' }
    let(:heading) { page_title }

    it_should_behave_like('all static pages')
  end

end
