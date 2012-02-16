class AddCurrencyToUser < ActiveRecord::Migration
  def change
    add_column :users, :currency_id, :integer
    add_index :users, :currency_id

  end
end
