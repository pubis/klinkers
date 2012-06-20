require 'spec_helper'

describe "Portfolios request" do
  before(:each) do
    @me = FactoryGirl.create(:user)
    manual_login
  end

  describe "#index" do
    it "lists portfolios" do
      FactoryGirl.create(:portfolio, :name => "Big investments", :user => @me)
      FactoryGirl.create(:account, :name => "Not a portfolio", :user => @me)
      visit portfolios_path
      page.should have_content("Big investments")
      page.should_not have_content("Not a portfolio")
    end
  end

  describe "#show" do
    it "displays a portfolio" do
      portfolio = FactoryGirl.create(:portfolio, :name => "Mighty investments", :user => @me)
      visit portfolio_path(portfolio)
      page.should have_content("Mighty investments")
    end
  end
end