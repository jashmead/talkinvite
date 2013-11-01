require "spec_helper"

describe StaticPagesController do
  describe "routing" do

    ## add in the search routes
    it "routing to static pages" do

      get("/static_pages/about").should route_to("static_pages#about")
      get("/static_pages/contact").should route_to("static_pages#contact")
      get("/static_pages/privacy").should route_to("static_pages#privacy")
      get("/static_pages/sitemap").should route_to("static_pages#sitemap")

      get("/about").should route_to("static_pages#about")
      get("/contact").should route_to("static_pages#contact")
      get("/sitemap").should route_to("static_pages#sitemap")

    end

  end
end
