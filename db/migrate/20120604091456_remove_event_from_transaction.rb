class RemoveEventFromTransaction < ActiveRecord::Migration
  def up
    remove_column :transactions, :event
  end

  def down
    add_column :transactions, :event, :string, :null => false
    execute("UPDATE transactions SET event = type;")
  end
end
