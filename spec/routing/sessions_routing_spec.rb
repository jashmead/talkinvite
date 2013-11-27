require "spec_helper"

describe SessionsController do
  describe "routing" do

    it "routes to #new" do
      get("/sessions/new").should route_to("sessions#new")
      get("/sign_in").should route_to("devise/sessions#new")
    end

    it "routes to #reset_password" do
      get("/sessions/reset_password").should route_to("sessions#reset_password")
      get("/reset_password").should route_to("sessions#reset_password")
    end

    it "routes to #create" do
      post("/sessions").should route_to("sessions#create")
    end

    it "routes to #destroy" do
      # TBD:  why do we need 'sessions' for first line, but 'devise/sessions' for 2nd?
      delete("/sessions/1").should route_to("sessions#destroy", :id => "1")
      delete("/sign_out").should route_to("devise/sessions#destroy")
    end

  end
end
