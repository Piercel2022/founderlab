class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :trackable,  polymorphic: true, null: false, foreign_key: true
      t.string :action
      t.text :details
      t.datetime :occurred_at

      t.timestamps
    end
  end
end
