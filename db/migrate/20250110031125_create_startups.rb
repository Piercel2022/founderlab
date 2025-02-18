class CreateStartups < ActiveRecord::Migration[8.0]
  
  def change
    create_table :startups do |t|
      t.string :name
      t.text :description
      t.date :founded_date
      t.string :website
      t.string :industry
      t.integer :company_size
      t.string :stage
      t.decimal :total_funding, precision: 10, scale: 2
      t.string :headquarters
      t.string :founders
      t.string :logo_url
      t.string :status
      t.string :pitch_deck_url
      t.decimal :valuation, precision: 10, scale: 2
      t.decimal :revenue, precision: 10, scale: 2
      t.integer :employee_count
      t.string :business_model
      t.string :target_market
      t.string :slug

      t.timestamps
    end
    add_index :startups, :slug, unique: true
  end
end
