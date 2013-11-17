require 'spec_helper'

describe "Posts" do

  # NOTE:  let & before are distinct; use one or the other, do not nest
  let(:person) { FactoryGirl.create(:person) }
  let(:person2) { FactoryGirl.create(:person) }
  let(:talk) { FactoryGirl.create(:talk, :person_id => person.id.to_s) }
  # post by originator
  let(:post) { FactoryGirl.create(:post, :talk_id => talk.id.to_s , :person_id => person.id.to_s) }
  # post by guest
  let(:post2) { FactoryGirl.create(:post, :talk_id => talk.id.to_s , :person_id => person2.id.to_s) }

  describe "GET /people/talks/posts" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get person_talk_post_path(person, talk, post)
      response.status.should be(200)
    end
  end
end
