class AddLocationToStartups < ActiveRecord::Migration[8.0]
  def change
    add_column :startups, :location, :string
  end
end
