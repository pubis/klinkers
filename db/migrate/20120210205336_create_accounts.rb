class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user
      t.string :name, :null => false
      t.string :number, :null => false, :default => ''
      t.boolean :system, :null => false, :default => false
      t.boolean :payee, :null => false, :default => false
      t.boolean :favorite, :null => false, :default => false

      t.timestamps
    end
    add_index :accounts, :user_id
    add_index :accounts, :system
    add_index :accounts, :payee
    add_index :accounts, :favorite
  end
end
