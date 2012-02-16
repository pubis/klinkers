class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :code, :null => false
      t.string :name, :null => false
      t.string :locale, :null => false

      t.timestamps
    end
    add_index :currencies, :code
    add_index :currencies, :name
  end
end
