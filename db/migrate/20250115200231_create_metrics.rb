class CreateMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :metrics do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.date :date
      t.decimal :revenue, precision: 10, scale: 2
      t.integer :total_users
      t.integer :active_users
      t.decimal :churn_rate, precision: 10, scale: 3
      t.decimal :customer_acquisition_cost, precision: 10, scale: 4
      t.decimal :lifetime_value, precision: 10, scale: 2
      t.decimal :burn_rate, precision: 10, scale: 3
      t.integer :runway_months
      t.decimal :funding_raised, precision: 10, scale: 2
      t.integer :investor_meetings
      t.integer :pilot_projects
      t.integer :partnerships
      t.integer :team_size
      t.integer :website_visits
      t.decimal :conversion_rate, precision: 10, scale: 2

      t.timestamps
    end
  end
end
