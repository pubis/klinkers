class AddTypeToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :type, :string
    add_index :accounts, :type
  end
end
