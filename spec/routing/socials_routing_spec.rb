require "spec_helper"

describe SocialsController do
  describe "routing" do

    it "routes to #index" do
      get("/socials").should route_to("socials#index")
    end

    it "routes to #new" do
      get("/socials/new").should route_to("socials#new")
    end

    it "routes to #show" do
      get("/socials/1").should route_to("socials#show", :id => "1")
    end

    it "routes to #edit" do
      get("/socials/1/edit").should route_to("socials#edit", :id => "1")
    end

    it "routes to #create" do
      post("/socials").should route_to("socials#create")
    end

    it "routes to #update" do
      put("/socials/1").should route_to("socials#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/socials/1").should route_to("socials#destroy", :id => "1")
    end

  end
end
