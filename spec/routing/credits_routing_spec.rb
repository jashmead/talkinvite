require "spec_helper"

describe CreditsController do
  describe "routing" do

    it "routes to #index" do
      get("/credits").should route_to("credits#index")
    end

    it "routes to #new" do
      get("/credits/new").should route_to("credits#new")
    end

    it "routes to #show" do
      get("/credits/1").should route_to("credits#show", :id => "1")
    end

    it "routes to #edit" do
      get("/credits/1/edit").should route_to("credits#edit", :id => "1")
    end

    it "routes to #create" do
      post("/credits").should route_to("credits#create")
    end

    it "routes to #update" do
      put("/credits/1").should route_to("credits#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/credits/1").should route_to("credits#destroy", :id => "1")
    end

  end
end
