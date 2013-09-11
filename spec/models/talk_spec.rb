require 'spec_helper'

describe Talk do

  # better to build up fresh person than to rely on the standard people (anonymous, talkinvite, ...)
  let(:person) { FactoryGirl.create(:person) }

  before { @talk = Talk.new( summary: "Example talk", description: "Let's talk!", person_id: person.id ) }

  subject { @talk }

  it { should respond_to(:summary) }
  it { should respond_to(:description) }
  it { should respond_to(:location_id) }
  it { should respond_to(:person_id) }

  it { should be_valid }

  describe "with a summary that's too short" do
    before { @talk.summary = "a" }
    it { should be_invalid }
  end

  describe "when person_id is not present" do
    before { @talk.person_id = nil }
    it { should_not be_valid }
  end

end
