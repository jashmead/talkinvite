require 'spec_helper'

describe Location do

  before { @location = Location.new( name: "here" ) }

  subject { @location }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:latitude) }
  it { should respond_to(:longitude) }
  it { should respond_to(:address) }

  it { should be_valid }
end
