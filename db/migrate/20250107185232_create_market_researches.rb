class CreateMarketResearches < ActiveRecord::Migration[8.0]
  def change
    create_table :market_researches do |t|
      t.references :project, null: false, foreign_key: true
      t.integer :market_size
      t.text :competitors
      t.text :target_audience
      t.text :pain_points
      t.text :opportunities

      t.timestamps
    end
  end
end
