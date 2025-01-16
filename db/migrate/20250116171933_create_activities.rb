class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :activity_type, null: false
      t.text :content
      t.references :trackable, polymorphic: true
      t.integer :likes_count, default: 0
      t.integer :comments_count, default: 0
      t.boolean :status_changed, default: false
      t.string :previous_status
      t.string :current_status
      t.jsonb :metadata, default: {}

      t.timestamps
    end

    add_index :activities, [:trackable_type, :trackable_id]
    add_index :activities, :activity_type
    add_index :activities, :created_at
  end
end
