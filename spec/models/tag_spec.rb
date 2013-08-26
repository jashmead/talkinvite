require 'spec_helper'

describe Tag do

  # tag_type should default to '', fix at some point
  before { @tag = Tag.new( tag: "Example", tag_type: 'tag', tagable_type: "talks", tagable_id: "1" ) }

  subject { @tag }

  it { should respond_to(:tag) }
  it { should respond_to(:tag_type) }
  it { should respond_to(:tagable_type) }
  it { should respond_to(:tagable_id) }

  it { should be_valid }

end
