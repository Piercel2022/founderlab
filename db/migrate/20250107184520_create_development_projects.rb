class CreateDevelopmentProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :development_projects do |t|
      t.references :project, null: false, foreign_key: true
      t.string :phase
      t.date :timeline
      t.decimal :budget, precision: 10, scale: 2
      t.string :tech_stack
      t.text :milestones
      t.timestamps
    end
  end
end
