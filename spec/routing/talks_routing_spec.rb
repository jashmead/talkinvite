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

    ## add in the search routes
    it "routes to #search" do

      get("/talks/category").should route_to("talks#category")
      get("/talks/found").should route_to("talks#found")            # found is internal path
      get("/talks/hot_talks").should route_to("talks#hot_talks")
      get("/talks/my_tags").should route_to("talks#my_tags")
      get("/talks/my_friends").should route_to("talks#my_friends")
      get("/talks/my_talks").should route_to("talks#my_talks")
      get("/talks/nearby").should route_to("talks#nearby")
      get("/talks/recent").should route_to("talks#recent")
      get("/talks/roulette").should route_to("talks#roulette")
      get("/talks/search").should route_to("talks#search")

      get("/category").should route_to("talks#category")
      get("/hot_talks").should route_to("talks#hot_talks")
      get("/my_friends").should route_to("talks#my_friends")
      get("/my_tags").should route_to("talks#my_tags")
      get("/my_talks").should route_to("talks#my_talks")
      get("/nearby").should route_to("talks#nearby")
      get("/recent").should route_to("talks#recent")
      get("/roulette").should route_to("talks#roulette")
      get("/search").should route_to("talks#search")

    end

  end
end
