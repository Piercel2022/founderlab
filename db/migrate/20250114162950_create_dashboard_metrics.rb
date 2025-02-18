class CreateDashboardMetrics < ActiveRecord::Migration[8.0]
  
  def change
    create_table :dashboard_metrics do |t|
      t.string :name
      t.integer :value
      t.string :category
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
