class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null => false
      t.string :email, :null => false
      t.string :password_digest
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
    add_index :users, :username
    add_index :users, :email
    add_index :users, :password_digest
  end
end
