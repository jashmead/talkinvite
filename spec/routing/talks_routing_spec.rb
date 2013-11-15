require "spec_helper"

describe TalksController do
  describe "routing" do

    it "routes to #index" do
      get("/people/1/talks").should route_to("talks#index", :person_id => "1")
    end

    it "routes to #new" do
      get("/people/1/talks/new").should route_to("talks#new", :person_id => "1")
    end

    it "routes to #show" do
      get("/people/1/talks/1").should route_to("talks#show", :id => "1", :person_id => "1")
    end

    it "routes to #edit" do
      get("/people/1/talks/1/edit").should route_to("talks#edit", :id => "1", :person_id => "1")
    end

    it "routes to #create" do
      post("/people/1/talks").should route_to("talks#create", :person_id => "1")
    end

    it "routes to #update" do
      put("/people/1/talks/1").should route_to("talks#update", :id => "1", :person_id => "1")
    end

    it "routes to #destroy" do
      delete("/people/1/talks/1").should route_to("talks#destroy", :id => "1", :person_id => "1")
    end

    ## to test 'start', we would have to setup a signed_in & a not signed_in case..., since 'start' forks on this condition

    it "member routes" do
      get("/people/1/talks/2/map").should route_to("talks#map", :id => "2", :person_id => "1")
    end

    it "collection routes" do
      get("/people/1/talks/found").should route_to("talks#found", :person_id => "1")            # found is internal path
      get("/people/1/talks/search").should route_to("talks#search", :person_id => "1")
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
