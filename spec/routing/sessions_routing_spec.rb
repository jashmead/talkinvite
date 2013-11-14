require "spec_helper"

describe SessionsController do
  describe "routing" do

    it "routes to #new" do
      get("/sessions/new").should route_to("sessions#new")
      get("/signin").should route_to("sessions#new")
    end

    it "routes to #create" do
      post("/sessions").should route_to("sessions#create")
    end

    it "routes to #destroy" do
      delete("/sessions/1").should route_to("sessions#destroy", :id => "1")
      delete("/signout").should route_to("sessions#destroy")
      get("/sayonara").should route_to("sessions#sayonara")
      get("/sessions/sayonara").should route_to("sessions#sayonara")
    end

  end
end
