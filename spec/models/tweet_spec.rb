require 'spec_helper'

describe Tweet do

  before { @tweet = Tweet.new( content: "stuff and also a bit of nonsense", post_id: "1" ) }

  subject { @tweet }

  it { should respond_to(:person_id) }
  it { should respond_to(:screen_name) }
  it { should respond_to(:content) }
  it { should respond_to(:location_id) }
  it { should respond_to(:post_id) }

  it { should be_valid }
end
