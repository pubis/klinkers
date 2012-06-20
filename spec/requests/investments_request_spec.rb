require 'spec_helper'

describe "Investments request" do
  context "nested under portfolio" do
    setup do
      @portfolio = FactoryGirl.create(:portfolio)
    end
    
    describe "#create" do
      it "creates a new investment associated with the portfolio" do
        
      end
    end
  end
end