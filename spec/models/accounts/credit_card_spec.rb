require 'spec_helper'

describe CreditCard do
  before(:all) do
    @credit_card = FactoryGirl.create(:credit_card, :opening_balance => -5000.0, :credit_limit => 10000)
  end

  context '#available' do
    it "should return balance + credit limit" do
      @credit_card.available.should eq(5000.0)
    end
  end
end