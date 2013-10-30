require "spec_helper"

describe VenuesController do
  describe "routing" do

    it "routes to #index" do
      get("/venues").should route_to("venues#index")
    end

    it "routes to #new" do
      get("/venues/new").should route_to("venues#new")
    end

    it "routes to #show" do
      get("/venues/1").should route_to("venues#show", :id => "1")
    end

    it "routes to #edit" do
      get("/venues/1/edit").should route_to("venues#edit", :id => "1")
    end

    it "routes to #create" do
      post("/venues").should route_to("venues#create")
    end

    it "routes to #update" do
      put("/venues/1").should route_to("venues#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/venues/1").should route_to("venues#destroy", :id => "1")
    end

    describe "search routes" do
      it "routes to #search" do
	      get("/venues/found").should route_to("venues#found")
	      get("/venues/search").should route_to("venues#search")
      end
    end

    it "routes to #map & #calendar" do
      get("/venues/1/map").should route_to("venues#map", :id => "1")
      get("/venues/1/calendar").should route_to("venues#calendar", :id => "1")
    end

  end
  
end
