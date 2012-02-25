class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :name, :null => false
      t.references :user, :null => false
      t.integer :interval, :null => false

      t.timestamps
    end
    add_index :budgets, :user_id
  end
end
