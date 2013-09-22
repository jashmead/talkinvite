require 'spec_helper'

describe Relationship do

  let(:from_person) { FactoryGirl.create(:person) }
  let(:to_person) { FactoryGirl.create(:person) }
  let(:relationship) { from_person.relationships.build(to_id: to_person.id) }

  subject { relationship }

  it { should be_valid }
end
