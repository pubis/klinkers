class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :null => false
      t.string :description
      t.integer :parent_id
      t.boolean :expense, :null => false, :default => false

      t.timestamps
    end
    add_index :categories, :name
    add_index :categories, :parent_id
    add_index :categories, :expense
  end
end
