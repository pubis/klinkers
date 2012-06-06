class AddTypeToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :type, :string, :null => false, :default => 'Transaction'
    add_index :transactions, :type
    
    execute("UPDATE transactions SET type = event;")
  end
end
