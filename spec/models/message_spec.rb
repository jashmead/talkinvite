require 'spec_helper'

describe Message do

  ## sender is 'left', receiver is 'right' -- does this help?
  let(:sender) { FactoryGirl.create(:person) }
  let(:receiver) { FactoryGirl.create(:person) }

  let(:message) { sender.messages.build(receiver_id: receiver.id) }

  subject { message }

  it { should be_valid }

  describe "sender methods" do

    ## next two lines satisfied as a result of the 'belongs_to' lines in models/message.rb
    it { should respond_to(:sender) }
    it { should respond_to(:receiver) }

    its(:sender) { should eq sender }
    its(:receiver) { should eq receiver }
  end

  describe "when receiver id is not present" do
    before { message.receiver_id = nil }
    it { should_not be_valid }
  end

  describe "when sender id is not present" do
    before { message.sender_id = nil }
    it { should_not be_valid }
  end

end
