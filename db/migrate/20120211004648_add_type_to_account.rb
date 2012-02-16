class AddTypeToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :account_type, :string, :null => false, :default => 'Account'
    add_index :accounts, :account_type

  end
end
