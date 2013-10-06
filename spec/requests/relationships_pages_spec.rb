require 'spec_helper'

describe 'relationships' do

  subject { page }

  describe "following/followers" do

    let(:person) { FactoryGirl.create(:person) }        # following

    before { visit person_path(person) }

    it { should have_content(person.name) }
    it { should have_title(person.name) }

    ## setup following/followed pair
    let(:other_person) { FactoryGirl.create(:person) }  # followed
    before { person.follow!(other_person) }

    describe "followed people" do
      before do
        sign_in person                                  # sign in the follower
        visit following_person_path(person)             # look at those we are following
      end

      it { should have_title('Following') }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_person.name, href: person_path(other_person)) }
    end

    describe "followers" do
      before do
        sign_in other_person                            # now start with the person being followed
        visit followers_person_path(other_person)       # and visit their followers
      end

      it { should have_title('Followers') }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(person.name, href: person_path(person)) }
    end

  end

end
