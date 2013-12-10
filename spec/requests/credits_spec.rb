require 'spec_helper'

# TBD: check out add/edit/destroy of credits; include check of url
describe "Credits" do
  describe "GET /credits" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get credits_path
      response.status.should be(200)
    end
  end
end
