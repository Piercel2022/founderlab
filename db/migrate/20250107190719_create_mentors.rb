class CreateMentors < ActiveRecord::Migration[8.0]
  def change
    create_table :mentors do |t|
      t.references :user, null: false, foreign_key: true
      t.string :expertise
      t.string :availability
      t.decimal :rating
      t.text :bio
      t.timestamps
    end
  end
end
