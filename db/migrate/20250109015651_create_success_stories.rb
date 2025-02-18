class CreateSuccessStories < ActiveRecord::Migration[8.0]
  
  def change
    create_table :success_stories do |t|
      t.string :title
      t.string :founder_name
      t.string :founder_avatar
      t.string :company_name
      t.string :industry
      t.text :summary
      t.string :funding_raised
      t.integer :team_size
      t.string :image_url

      t.timestamps
    end
  end
end
