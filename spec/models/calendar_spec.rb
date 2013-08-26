require 'spec_helper'

describe Calendar do

  before { @calendar = Calendar.new( person_id: "1", name: "Map Name", time_point: Time.now, source: "{ nearby: true}", settings: "" ) }

  subject { @calendar }

  it { should respond_to(:person_id) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:time_point) }
  it { should respond_to(:source) }
  it { should respond_to(:settings) }

  it { should be_valid }
end
