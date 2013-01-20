require "spec_helper"

describe ScansController do
  describe "routing" do

    it "routes to #index" do
      get("/scans").should route_to("scans#index")
    end

    it "routes to #new" do
      get("/scans/new").should route_to("scans#new")
    end

    it "routes to #show" do
      get("/scans/1").should route_to("scans#show", :id => "1")
    end


  end
end
