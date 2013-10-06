require 'spec_helper'

describe Relationship do

<<<<<<< HEAD
  ## follower is 'left', followed is 'right' -- does this help?
  let(:follower) { FactoryGirl.create(:person) }
  let(:followed) { FactoryGirl.create(:person) }
  ## relationship starts with follower, so should have follower_id set to that person
  ## relationship now being told that its followed_id is to be set to follower.id

  ## going 'left' to 'right', follower to followed
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }

  describe "follower methods" do
    ## next two lines satisfied as a result of the 'belongs_to' lines in models/relationship.rb
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }

    ## next two lines satisfied because of the 'build' call above
    ## are we saying that relationship.follower = :follower?
    ##  -- that will imply that mentioning relationship.follower causes a 
    ##    lookup of the person associated with follower.id
    its(:follower) { should eq follower }
    ## and that relationship.followed = :followed?
    its(:followed) { should eq followed }
  end

  describe "when followed id is not present" do
    before { relationship.followed_id = nil }
    it { should_not be_valid }
  end

  describe "when follower id is not present" do
    before { relationship.follower_id = nil }
=======
  let(:from_person) { FactoryGirl.create(:person) }
  let(:to_person) { FactoryGirl.create(:person) }
  let(:relationship) { from_person.relationships.build(to_id: to_person.id) }

  subject { relationship }

  describe "from_person methods" do
    it { should respond_to(:from_person) }
    it { should respond_to(:to_person) }
    its(:from_person) { should eq from_person }
    its(:to_person) { should eq to_person }
  end

  it { should be_valid }

  describe "when to id is not present" do
    before { relationship.to_id = nil }
    it { should_not be_valid }
  end

  describe "when from id is not present" do
    before { relationship.from_id = nil }
>>>>>>> relationships
    it { should_not be_valid }
  end

end
