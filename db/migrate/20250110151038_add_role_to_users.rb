class AddRoleToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :string
    add_index :users, :role
  end

  def down
    remove_index :users, :role
    remove_column :users, :role
  end
end
