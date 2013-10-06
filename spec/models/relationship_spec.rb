require 'spec_helper'

describe "relationships" do

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
    it { should_not be_valid }
  end

end
