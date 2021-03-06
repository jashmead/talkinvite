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
      post("/people").should route_to("devise/registrations#create")
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
        get("/people/home").should route_to("people#home")
      end
    end

    it "routes to account management tool" do
      get("/home").should route_to("people#home")
    end

  end

end
