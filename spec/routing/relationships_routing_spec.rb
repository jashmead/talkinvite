require "spec_helper"

describe RelationshipsController do
  describe "routing" do

    it "routes to #create" do
      post("/relationships").should route_to("relationships#create")
    end

    it "routes to #destroy" do
      delete("/relationships/1").should route_to("relationships#destroy", :id => "1")
    end

  end
end
