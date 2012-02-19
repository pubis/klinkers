class TransactionItem < ActiveRecord::Base
  validates :amount, :presence => true, :numericality => true
    
  belongs_to :account
  belongs_to :transaction
  belongs_to :category
  
  attr_accessor :payee, :to_account
end
