require 'spec_helper'

describe Post do
  before { @post = Post.new( person_id: "1", talk_id: "1", post_type: "create") }

  subject { @post }

  it { should respond_to(:person_id) }
  it { should respond_to(:talk_id) }
  it { should respond_to(:post_type) }
  it { should respond_to(:comment) }

  it { should be_valid }

end
