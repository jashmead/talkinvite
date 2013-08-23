require 'spec_helper'

describe StaticPagesController do

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'credits'" do
    it "returns http success" do
      get 'credits'
      response.should be_success
    end
  end

  describe "GET 'help'" do
    it "returns http success" do
      get 'help'
      response.should be_success
    end
  end

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'menu'" do
    it "returns http success" do
      get 'menu'
      response.should be_success
    end
  end

  describe "GET 'splash'" do
    it "returns http success" do
      get 'splash'
      response.should be_success
    end
  end

end
