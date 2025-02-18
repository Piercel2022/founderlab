class CreateResources < ActiveRecord::Migration[8.0]
  def change
    create_table :resources do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :file_url
      t.string :access_level
      t.timestamps
    end
  end
end
