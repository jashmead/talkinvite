require 'spec_helper'

describe Map do

  before { @map = Map.new( person_id: "1", name: "Map Name", source: "{ nearby: true}", settings: "" ) }

  subject { @map }

  it { should respond_to(:person_id) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:location_id) }
  it { should respond_to(:source) }
  it { should respond_to(:settings) }

  it { should be_valid }
end
