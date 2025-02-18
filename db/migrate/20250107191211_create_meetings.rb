class CreateMeetings < ActiveRecord::Migration[8.0]
  def change
    create_table :meetings do |t|
      t.references :mentor, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :date
      t.string :status
      t.text :notes
      t.string :meeting_type
      t.timestamps
    end
  end
end
