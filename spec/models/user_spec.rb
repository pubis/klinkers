require 'spec_helper'

describe User do
  context 'when first created' do
    before(:all) do
      @user = Factory.create(:user)
    end
    
    it 'gets persisted' do
      @user.should be_persisted
    end
    
    it 'has a net worth of 0.0' do
      @user.net_worth.should eq(0.0)
    end
    
    it "has system accounts" do
      system_account_names = @user.accounts.where(system: true).pluck(:name)
      system_account_names.should include("Taxes", "Opening balances")
    end
  end
  
  context "net_worth" do
    it "should update when adding an account" do
      user = Factory.create(:user)
      user.net_worth.should eq(0.0)
      account = Factory.create(:account, :user => user, :opening_balance => "123.50")
      user.net_worth.should eq(123.50)
    end
  end
end
