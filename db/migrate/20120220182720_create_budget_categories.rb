class CreateBudgetCategories < ActiveRecord::Migration
  def change
    create_table :budget_categories do |t|
      t.references :budget, :null => false
      t.references :category, :null => false
      t.decimal :amount, :precision => 9, :scale => 2, :null => false

      t.timestamps
    end
    add_index :budget_categories, :budget_id
    add_index :budget_categories, :category_id
  end
end
