## member_stories_spec -- check accept/decline/maybe

describe "check member stories" do

  let(:person) { FactoryGirl.create(:person) }
  let(:talk) { FactoryGirl.create(:talk) }

  describe "accept/decline/maybe" do

    describe "already member" do
      pending "check accept" 
      pending "check decline" 
      pending "check maybe" 
    end

    describe "not already member" do
      pending "check accept" 
      pending "check decline" 
      pending "check maybe" 
    end

    describe "no change in member type by others unless admin" do
      pending "other not admin"
      pending "other is admin"
    end

  end

  describe "admin/unadmin" do

    pending "make admin if creator"

    pending "make admin if current user is admin"

    pending "do not make admin if current user is not admin and not creator"

    pending "make unadmin if creator"

    pending "make unadmin if self"

    pending "no not make unadmin if current user is not the member and not admin"

  end

end
