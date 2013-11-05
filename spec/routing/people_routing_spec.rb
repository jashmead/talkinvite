require "spec_helper"

describe PeopleController do
  describe "routing" do

    it "routes to #index" do
      get("/people").should route_to("people#index")
    end

    it "routes to #new" do
      get("/people/new").should route_to("people#new")
    end

    it "routes to #show" do
      get("/people/1").should route_to("people#show", :id => "1")
    end

    it "routes to #edit" do
      get("/people/1/edit").should route_to("people#edit", :id => "1")
    end

    it "routes to #create" do
      post("/people").should route_to("people#create")
    end

    it "routes to #update" do
      put("/people/1").should route_to("people#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/people/1").should route_to("people#destroy", :id => "1")
    end

    describe "search routes" do
      it "routes to #search" do
        get("/people/found").should route_to("people#found")
        get("/people/search").should route_to("people#search")
        get("/people/upgrade").should route_to("people#upgrade")
        get("/people/home").should route_to("people#home")
      end
      it "routes to personalized #search" do
        get("/people/1/oauth").should route_to("people#oauth", :id => "1")
      end
    end

    it "routes to account management tool" do
      get("/profile").should route_to("people#show")
      get("/settings").should route_to("people#settings")
      get("/signup").should route_to("people#new")
      get("/upgrade").should route_to("people#upgrade")
      get("/home").should route_to("people#home")
    end

    it "routes to #map" do
      get("/people/1/map").should route_to("people#map", :id => "1")
    end

  end

end
