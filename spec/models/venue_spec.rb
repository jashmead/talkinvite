require 'spec_helper'

describe Venue do

  # better to build up fresh person than to rely on the standard people (anonymous, venueinvite, ...)
  let(:person) { FactoryGirl.create(:person) }
  before { @venue = person.venues.build(name: "Nowhere", description: "Let's go here!") }

  subject { @venue }

  it { should respond_to(:person_id) }
  it { should respond_to(:venue_type) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:longitude) }
  it { should respond_to(:latitude) }
  it { should respond_to(:description) }

  it { should respond_to(:talks) }

  # it { should respond_to(:tagable) }
  it { should respond_to(:tags) }

  its(:person) { should eq person }

  it { should be_valid }

  describe "when person_id is not present" do
    before { @venue.person_id = nil }
    it { should_not be_valid }
  end

end
