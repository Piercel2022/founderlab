class CreateInvestments < ActiveRecord::Migration[8.0]
  def change
    create_table :investments do |t|
      t.references :startup, null: false, foreign_key: true
      t.decimal :amount
      t.date :investment_date
      t.string :investment_type
      t.string :investor_name
      t.string :investment_round
      t.decimal :equity_percentage, precision: 10, scale: 2
      t.decimal :valuation_at_investment, precision: 10, scale: 2
      t.text :investment_terms
      t.integer :board_seats
      t.string :due_diligence_status
      t.string :documents_url
      t.boolean :lead_investor
      t.boolean :follow_on_investment
      t.text :notes
      t.string :status

      t.timestamps
    end
  end
end
