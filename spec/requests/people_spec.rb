require 'spec_helper'

describe "People" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title('Sign up') }
  end

  describe "profile page" do
    before { visit person_path(person) }

    it { should have_content(person.name) }
    it { should have_title(person.name) }
  end

end
