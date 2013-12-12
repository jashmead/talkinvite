# add the status changing functions here!  10 functions, therefore 20 tests

require 'spec_helper'

describe Partner do

  ## person is 'left', talk is 'right' -- does this help?
  let(:person) { FactoryGirl.create(:person) }
  let(:talk) { FactoryGirl.create(:talk) }

  ## going 'left' to 'right', person to talk
  let(:partner) { person.partners.build(talk_id: talk.id, rsvp_status: 'yes') }

  subject { partner }

  it { should be_valid }

  describe "person methods" do
    ## next two lines satisfied as a result of the 'belongs_to' lines in models/partner.rb
    it { should respond_to(:person) }
    it { should respond_to(:talk) }
    it { should respond_to(:partner_type) }
    it { should respond_to(:rsvp_status) }

    its(:person) { should eq person }
    its(:talk) { should eq talk }
  end

  describe "when talk id is not present" do
    before { partner.talk_id = nil }
    it { should_not be_valid }
  end

  describe "when person id is not present" do
    before { partner.person_id = nil }
    it { should_not be_valid }
  end

  describe "when partner type is invalid" do
    before { partner.partner_type = 'groucho marx' }
    it { should_not be_valid }
  end

  describe "when rsvp status is invalid" do
    before { partner.rsvp_status = 'stuff and also nonsense' }
    it { should_not be_valid }
  end

end
