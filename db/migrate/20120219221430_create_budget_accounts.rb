class CreateBudgetAccounts < ActiveRecord::Migration
  def change
    create_table :budget_accounts do |t|
      t.references :budget, :null => false
      t.references :account, :null => false

      t.timestamps
    end
    add_index :budget_accounts, :budget_id
    add_index :budget_accounts, :account_id
  end
end
