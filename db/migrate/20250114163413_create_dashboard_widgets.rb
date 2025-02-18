class CreateDashboardWidgets < ActiveRecord::Migration[8.0]
  def change
    create_table :dashboard_widgets do |t|
      t.string :name
      t.string :widget_type
      t.integer :position
      t.references :user, null: false, foreign_key: true
      t.jsonb :settings

      t.timestamps
    end
  end
end
