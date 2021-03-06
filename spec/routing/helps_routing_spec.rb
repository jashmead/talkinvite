require "spec_helper"

describe HelpsController do
  describe "routing" do

    it "routes to #index" do
      get("/helps").should route_to("helps#index")
    end

    it "routes to #new" do
      get("/helps/new").should route_to("helps#new")
    end

    it "routes to #show" do
      get("/helps/1").should route_to("helps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/helps/1/edit").should route_to("helps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/helps").should route_to("helps#create")
    end

    it "routes to #update" do
      put("/helps/1").should route_to("helps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/helps/1").should route_to("helps#destroy", :id => "1")
    end

    it "routes to #help when given a name" do
      # NOTE:  since help action fans out into index, show, & edit, we only need to hit the controller action to get a match on routing
      get("/help/named_help").should route_to("helps#help", :name => "named_help")
      get("/helps/named_help").should route_to("helps#help", :name => "named_help")
    end

  end
end
