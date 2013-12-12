require 'spec_helper'

describe Post do

  let(:person) { FactoryGirl.create(:person) }
  let(:person2) { FactoryGirl.create(:person) }

  let(:talk) { FactoryGirl.create(:talk, person_id: person.id) }

  before { @post = talk.posts.build(person_id: person2.id, routing: 'message', post_type: 'new talk', post_title: 'we begin' ) }

  subject { @post }

  it { should respond_to(:person_id) }
  it { should respond_to(:talk_id) }
  it { should respond_to(:routing) }
  it { should respond_to(:post_type) }
  it { should respond_to(:post_message) }
  it { should respond_to(:post_title) }

  it { should respond_to(:person) }
  it { should respond_to(:talk) }

  # its(:person) { should eq person } # not necessarily true
  its(:talk) { should eq talk }

  it { should be_valid }

  describe "when person_id is not present" do
    before { @post.person_id = nil }
    it { should_not be_valid }
  end

  describe "when talk_id is not present" do
    before { @post.talk_id = nil }
    it { should_not be_valid }
  end

  describe "with a title that's too short" do
    before { @post.post_title = "" }
    it { should be_invalid }
  end

end
