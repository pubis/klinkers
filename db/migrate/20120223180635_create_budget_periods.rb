class CreateBudgetPeriods < ActiveRecord::Migration
  def change
    create_table :budget_periods do |t|
      t.references :budget
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
    add_index :budget_periods, :budget_id
    add_index :budget_periods, :start_date
    add_index :budget_periods, :end_date
  end
end
