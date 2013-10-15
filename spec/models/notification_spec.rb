require 'spec_helper'

describe Notification do

  ## person is 'left', talk is 'right' -- does this help?
  let(:person) { FactoryGirl.create(:person) }
  let(:talk) { FactoryGirl.create(:talk) }

  ## going 'left' to 'right', person to talk
  let(:notification) { person.notifications.build(talk_id: talk.id, note_type: 'announce') }

  subject { notification }

  it { should be_valid }

  describe "person methods" do
    ## next two lines satisfied as a result of the 'belongs_to' lines in models/notification.rb
    it { should respond_to(:person) }
    it { should respond_to(:talk) }
    it { should respond_to(:note_type) }
    it { should respond_to(:note_text) }

    its(:person) { should eq person }
    its(:talk) { should eq talk }
  end

  describe "when talk id is not present" do
    before { notification.talk_id = nil }
    it { should_not be_valid }
  end

  describe "when person id is not present" do
    before { notification.person_id = nil }
    it { should_not be_valid }
  end

  describe "when notification type is invalid" do
    before { notification.note_type = 'groucho marx' }
    it { should_not be_valid }
  end

end
