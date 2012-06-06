class AddTypeToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :type, :string, :null => false, :default => 'Account'
    add_index :accounts, :type

    execute("UPDATE accounts SET type = account_type;")
    execute("UPDATE accounts SET type = 'Payee' WHERE payee = 1;")
  end
end
