class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :event, :null => false
      t.date :operation_date, :null => false

      t.timestamps
    end
    add_index :transactions, :operation_date
  end
end
