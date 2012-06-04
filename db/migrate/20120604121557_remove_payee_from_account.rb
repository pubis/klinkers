class RemovePayeeFromAccount < ActiveRecord::Migration
  def up
    remove_column :accounts, :payee
  end

  def down
    add_column :accounts, :payee, :boolean, :default => false, :null => false
    add_index :accounts, :payee
    execute("UPDATE accounts SET payee = 1 WHERE type = 'Payee'")
  end
end
