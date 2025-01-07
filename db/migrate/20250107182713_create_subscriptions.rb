class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :plan_type
      t.date :start_date
      t.date :end_date
      t.string :status
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
