class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.string :target_market
      t.string :revenue_model

      t.timestamps
    end
  end
end
