class RemoveAccounttypeFromAccounts < ActiveRecord::Migration
  def up
    remove_column :accounts, :account_type
  end

  def down
    add_column :accounts, :account_type, :string, :default => 'Account', :null => false
    add_index :accounts, :account_type
    execute("UPDATE accounts SET account_type = type")
  end
end
