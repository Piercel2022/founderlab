class AddTeamSizeToStartups < ActiveRecord::Migration[8.0]
  
  def change
    add_column :startups, :team_size, :integer
  end
end
