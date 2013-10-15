require 'spec_helper'

describe Social do

  ## person is 'left', talk is 'right' -- does this help?
  let(:person) { FactoryGirl.create(:person) }
  let(:talk) { FactoryGirl.create(:talk) }

  ## going 'left' to 'right', person to talk
  let(:social) { person.socials.build(talk_id: talk.id, social_type: 'talkinvite', social_text: "let's get talking!") }

  subject { social }

  it { should be_valid }

  describe "person methods" do
    ## next two lines satisfied as a result of the 'belongs_to' lines in models/social.rb
    it { should respond_to(:person) }
    it { should respond_to(:talk) }
    it { should respond_to(:social_type) }
    it { should respond_to(:social_text) }

    its(:person) { should eq person }
    its(:talk) { should eq talk }
  end

  describe "when talk id is not present" do
    before { social.talk_id = nil }
    it { should_not be_valid }
  end

  describe "when person id is not present" do
    before { social.person_id = nil }
    it { should_not be_valid }
  end

  describe "when social type is invalid" do
    before { social.social_type = 'groucho marx' }
    it { should_not be_valid }
  end

end
