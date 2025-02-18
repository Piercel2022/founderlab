class CreateLoginHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :login_histories do |t|
      t.timestamps
    end
  end
end
