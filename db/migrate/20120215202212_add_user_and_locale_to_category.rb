class AddUserAndLocaleToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :user_id, :integer
    add_index :categories, :user_id

    add_column :categories, :locale, :string, :null => false, :default => 'en'

  end
end
