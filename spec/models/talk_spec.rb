require 'spec_helper'

describe Talk do

  # better to build up fresh person than to rely on the standard people (anonymous, talkinvite, ...)
  let(:person) { FactoryGirl.create(:person) }
  before { @talk = person.talks.build(summary: "Lorem ipsum", description: "Let's talk!") }

  subject { @talk }

  it { should respond_to(:summary) }
  it { should respond_to(:description) }
  it { should respond_to(:person_id) }
  it { should respond_to(:person) }

  it { should respond_to(:members) }
  it { should respond_to(:comments) }

  its(:person) { should eq person }

  it { should be_valid }

  describe "with a summary that's too short" do
    before { @talk.summary = "a" }
    it { should be_invalid }
  end

  describe "with a summary that's too long" do
    ## the string has to come before the '256', so that we coerce towards string
    before { @talk.summary = "a" * 256  }
    it { should be_invalid }
  end

  describe "when person_id is not present" do
    before { @talk.person_id = nil }
    it { should_not be_valid }
  end

end
