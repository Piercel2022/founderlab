class CreateAnalyticsReports < ActiveRecord::Migration[8.0]
  def change
    create_table :analytics_reports do |t|
      t.references :project, null: false, foreign_key: true
      t.jsonb :metrics
      t.text :insights
      t.text :recommendations
      t.date :date
      t.string :report_type

      t.timestamps
    end
  end
end
