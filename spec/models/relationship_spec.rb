require 'spec_helper'

describe Relationship do

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
    it { should_not be_valid }
  end

end
