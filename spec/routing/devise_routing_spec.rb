require "spec_helper"

describe "devise controller" do

  describe "routing" do

    it "uses devise_for routes" do

			get("/people/sign_in").should route_to("devise/sessions#new")
			post("/people/sign_in").should route_to("devise/sessions#create")
			get("/people/sign_out").should route_to("devise/sessions#destroy")
			post("/people/password").should route_to("devise/passwords#create")
			get("/people/password/new").should route_to("devise/passwords#new")
			get("/people/password/edit").should route_to("devise/passwords#edit")
			patch("/people/password").should route_to("devise/passwords#update")
			put("/people/password").should route_to("devise/passwords#update")
			get("/people/cancel").should route_to("devise/registrations#cancel")
			post("/people").should route_to("devise/registrations#create")
			get("/people/sign_up").should route_to("devise/registrations#new")
			get("/people/edit").should route_to("devise/registrations#edit")
			patch("/people").should route_to("devise/registrations#update")
			put("/people").should route_to("devise/registrations#update")
			delete("/people").should route_to("devise/registrations#destroy")

    end

    it "uses custom routes" do

      get("/sign_up").should route_to("devise/registrations#new")
      get("/sign_in").should route_to("devise/sessions#new")
      delete("/sign_out").should route_to("devise/sessions#destroy")
      get("/reset_password").should route_to("devise/passwords#new")
      get("/settings").should route_to("devise/registrations#edit")

    end

  end

end
