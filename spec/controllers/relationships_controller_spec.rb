## NOTE 'xhr' does not work when this is given as a requests spec, must live in controllers
##  see tutorial for statement of this
##  no explanation, however, it doesn't appear to make sense
require 'spec_helper'

describe RelationshipsController do

  ## setup pair we need for any relationship
  let(:person) { FactoryGirl.create(:person) }
  let(:other_person) { FactoryGirl.create(:person) }

  ## why no_capybara?
  before { sign_in person, no_capybara: true }

  ## very similar in flow to follow/unfollow with people_pages_spec.rb
  describe "creating a relationship with Ajax" do

    it "should increment the Relationship count" do
      expect do
        xhr :post, :create, relationship: { followed_id: other_person.id }
      end.to change(Relationship, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :create, relationship: { followed_id: other_person.id }
      expect(response).to be_success
    end
  end

  describe "destroying a relationship with Ajax" do

    before { person.follow!(other_person) }
    let(:relationship) { person.relationships.find_by(followed_id: other_person) }

    it "should decrement the Relationship count" do
      expect do
        xhr :delete, :destroy, id: relationship.id
      end.to change(Relationship, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, :destroy, id: relationship.id
      expect(response).to be_success
    end
  end
end
