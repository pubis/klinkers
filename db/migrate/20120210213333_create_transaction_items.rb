class CreateTransactionItems < ActiveRecord::Migration
  def change
    create_table :transaction_items do |t|
      t.integer :account_id, :null => false
      t.integer :transaction_id, :null => false
      t.integer :category_id
      t.string :memo
      t.decimal :amount, :precision => 9, :scale => 2, :null => false

      t.timestamps
    end
    add_index :transaction_items, :account_id
    add_index :transaction_items, :transaction_id
    add_index :transaction_items, :category_id
  end
end
