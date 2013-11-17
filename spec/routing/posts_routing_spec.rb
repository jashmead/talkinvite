require "spec_helper"

describe PostsController do
  describe "routing" do

    it "routes to #index" do
      get("/people/1/talks/2/posts").should route_to("posts#index", :person_id => "1", :talk_id => "2")
    end

    it "routes to #new" do
      get("/people/1/talks/2/posts/new").should route_to("posts#new", :person_id => "1", :talk_id => "2")
    end

    it "routes to #show" do
      get("/people/1/talks/2/posts/3").should route_to("posts#show", :id => "3", :person_id => "1", :talk_id => "2")
    end

    it "routes to #edit" do
      get("/people/1/talks/2/posts/3/edit").should route_to("posts#edit", :id => "3", :person_id => "1", :talk_id => "2")
    end

    it "routes to #create" do
      post("/people/1/talks/2/posts").should route_to("posts#create", :person_id => "1", :talk_id => "2")
    end

    it "routes to #update" do
      put("/people/1/talks/2/posts/3").should route_to("posts#update", :id => "3", :person_id => "1", :talk_id => "2")
    end

    it "routes to #destroy" do
      delete("/people/1/talks/2/posts/3").should route_to("posts#destroy", :id => "3", :person_id => "1", :talk_id => "2")
    end

  end

end
