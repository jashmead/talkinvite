require 'spec_helper'

describe Comment do

  ## person is 'left', talk is 'right' -- does this help?
  let(:person) { FactoryGirl.create(:person) }
  let(:talk) { FactoryGirl.create(:talk) }

  ## going 'left' to 'right', person to talk
  let(:comment) { person.comments.build(talk_id: talk.id, comment_text: 'this is a comment') }

  subject { comment }

  it { should be_valid }

  describe "person methods" do
    ## next two lines satisfied as a result of the 'belongs_to' lines in models/comment.rb
    it { should respond_to(:person) }
    it { should respond_to(:talk) }
    it { should respond_to(:comment_text) }

    its(:person) { should eq person }
    its(:talk) { should eq talk }
  end

  describe "when talk id is not present" do
    before { comment.talk_id = nil }
    it { should_not be_valid }
  end

  describe "when person id is not present" do
    before { comment.person_id = nil }
    it { should_not be_valid }
  end

  describe "when comment text is not present" do
    before { comment.comment_text = nil }
    it { should_not be_valid }
  end

end
