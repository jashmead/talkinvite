require 'spec_helper'

describe Talk do

  before { @talk = Talk.new( summary: "Example talk", description: "Let's talk!" ) }

  subject { @talk }

  it { should respond_to(:summary) }
  it { should respond_to(:description) }
  it { should respond_to(:location_id) }

  it { should be_valid }

  describe "with a summary that's too short" do
    before { @talk.summary = "a" }
    it { should be_invalid }
  end

end
