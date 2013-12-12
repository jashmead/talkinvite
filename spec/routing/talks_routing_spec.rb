require "spec_helper"

describe TalksController do
  describe "routing" do

    it "routes to #index" do
      get("/talks").should route_to("talks#index")
    end

    it "routes to #new" do
      get("/talks/new").should route_to("talks#new")
    end

    it "routes to #show" do
      get("/talks/1").should route_to("talks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/talks/1/edit").should route_to("talks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/talks").should route_to("talks#create")
    end

    it "routes to #update" do
      put("/talks/1").should route_to("talks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/talks/1").should route_to("talks#destroy", :id => "1")
    end

    ## to test 'start', we would have to setup a signed_in & a not signed_in case..., since 'start' forks on this condition

    it "partner routes" do
      get("/talks/1/map").should route_to("talks#map", :id => "1")
      get("/talks/1/control").should route_to("talks#control", :id => "1")
    end

    it "collection routes" do
      get("/talks/found").should route_to("talks#found")            # found is internal path
      get("/talks/search").should route_to("talks#search")
    end

    it "anonymous special routes" do
      get("/talks").should route_to("talks#index")

      get("/talks/search").should route_to("talks#search")
      get("/search").should route_to("talks#search")

      get("/talks/start").should route_to("talks#start")
      get("/start").should route_to("talks#start")

      get("/talks/new").should route_to("talks#new")
    end

  end

end
