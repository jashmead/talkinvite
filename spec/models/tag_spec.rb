require 'spec_helper'

describe Tag do

  let(:talk) { FactoryGirl.create(:talk) }
  before { @tag = talk.tags.build( tagable_type: 'talks', tagable_id: talk.id, tag_type: "You're it" ) }

  subject { @tag }

  it { should respond_to(:tag_type) }
  it { should respond_to(:tagable_type) }
  it { should respond_to(:tagable_id) }

end
