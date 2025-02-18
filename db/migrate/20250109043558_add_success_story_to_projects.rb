class AddSuccessStoryToProjects < ActiveRecord::Migration[8.0]
  
  def change
    add_column :projects, :success_story, :boolean, default:false
  end
end
