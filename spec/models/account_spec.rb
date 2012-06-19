require 'spec_helper'

describe Account do
  context "when first created" do
    context "without opening_balance or opening_date" do
      before(:all) do
        @account = FactoryGirl.create(:account)
      end
      
      it "should have a balance of zero" do
        @account.balance.should eq(0.0)
      end
      
      it "should have opening_date today" do
        @account.opening_date.should eq(Date.today)
      end
    end
    
    context "with opening_balance" do
      before(:all) do
        @account = FactoryGirl.create(:account, :opening_balance => "123.45")
      end
      
      it "should have correct balance" do
        @account.balance.should eq(123.45)
      end
      
      it "should have opening_date today" do
        @account.opening_date.should eq(Date.today)
      end
    end

    context "with opening_balance and opening_date" do
      before(:all) do
        @account = FactoryGirl.create(:account, :opening_balance => "123.45", :opening_date => "2012-01-01")
      end
      
      it "should have correct balance" do
        @account.balance.should eq(123.45)
      end
      
      it "should have correct opening_date" do
        @account.opening_date.should eq("2012-01-01")
      end
    end
  end
  
  context 'balance_as_of' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @payee = @user.payees.create(FactoryGirl.attributes_for(:payee, :opening_date => "1999-12-31"))
      @remote = @user.accounts.create(FactoryGirl.attributes_for(:account, :opening_date => "1999-12-31"))
    end
    
    it "returns zero if date is before first transaction (opening_date)" do
      account = @user.accounts.create(FactoryGirl.attributes_for(:account, :opening_date => Date.today, :opening_balance => "25"))
      account.balance_as_of(1.day.ago).should eq(0.0)
      account.balance_as_of(1.month.ago).should eq(0.0)
      account.balance_as_of(1.year.ago).should eq(0.0)
    end
    
    it "returns sum of transaction up to a date" do
      account = @user.accounts.create(FactoryGirl.attributes_for(:account, :opening_date => "1999-01-01", :opening_balance => "0.0"))
      account.balance_as_of(Date.today).should eq(0.0)
      transfer = account.build_transaction(
        type: 'Transfer',
        operation_date: "1999-01-01",
        amount: "-11.01",
        memo: 'a transfer of 11.01',
        account: @remote.name
      )
      transfer.save
      account.balance_as_of("1999-01-01").should eq(11.01)
      account.balance_as_of(Date.today).should eq(11.01)
      deposit = account.build_transaction(
        type: 'Deposit',
        operation_date: "2010-12-31",
        account: @payee.name,
        amount: "99.99"
      )
      deposit.save
      account.balance_as_of("1999-01-01").should eq(11.01)
      account.balance_as_of("2010-12-31").should eq(111.0)
      account.balance_as_of(Date.today).should eq(111.0)
    end
  end

  context "when subclassed" do
    class DummyAccount < Account
    end

    it "should use the parents model_name" do
      DummyAccount.model_name.should eq("Account")
    end

    it "should be aware of the children" do
      Account.select_options.should include("DummyAccount")
    end
  end
end