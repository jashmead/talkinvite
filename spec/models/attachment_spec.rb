require 'spec_helper'

describe Attachment do

  before { @attachment = Attachment.new( 
    person_id: "1", 
    name: "attachment1", 
    file_type: "", 
    pathname: "attachment1",
    attachable_type: "talks", 
    attachable_id: "1")
  }

  subject { @attachment }

  it { should respond_to(:person_id) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:file_type) }
  it { should respond_to(:attachable_type) }
  it { should respond_to(:attachable_id) }

  it { should be_valid }

end
