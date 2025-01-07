class CreateForums < ActiveRecord::Migration[8.0]
  def change
    create_table :forums do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :status

      t.timestamps
    end
  end
end
