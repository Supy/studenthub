require "rails_helper"

RSpec.describe TextbooksController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/textbooks").to route_to("textbooks#index")
    end

    it "routes to #new" do
      expect(:get => "/textbooks/new").to route_to("textbooks#new")
    end

    it "routes to #show" do
      expect(:get => "/textbooks/1").to route_to("textbooks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/textbooks/1/edit").to route_to("textbooks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/textbooks").to route_to("textbooks#create")
    end

    it "routes to #update" do
      expect(:put => "/textbooks/1").to route_to("textbooks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/textbooks/1").to route_to("textbooks#destroy", :id => "1")
    end

  end
end
