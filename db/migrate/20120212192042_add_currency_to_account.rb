class AddCurrencyToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :currency_id, :integer
    add_index :accounts, :currency_id

  end
end
