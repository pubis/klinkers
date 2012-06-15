class CreatePortfolioInvestments < ActiveRecord::Migration
  def change
    create_table :portfolio_investments do |t|
      t.references :portfolio
      t.references :investment

      t.timestamps
    end
    add_index :portfolio_investments, :portfolio_id
    add_index :portfolio_investments, :investment_id
  end
end
