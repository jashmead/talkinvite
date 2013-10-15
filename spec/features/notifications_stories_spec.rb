## notification_stories_spec -- check announce/cancel/modify

describe "check notification stories" do

  let(:person) { FactoryGirl.create(:person) }
  let(:talk) { FactoryGirl.create(:talk) }

  describe "announce/modify/cancel" do

    describe "already notification" do
      pending "check announce" 
      pending "check cancel" 
      pending "check modify" 
    end

    describe "not already notification" do
      pending "check announce" 
      pending "check cancel" 
      pending "check modify" 
    end

    describe "no change in notification type by others unless admin" do
      pending "other not admin"
      pending "other is admin"
    end

  end

end
