class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id
      t.integer :visited_id
      t.integer :review_id
      t.integer :comment_id
      t.integer :follow_id
      t.string :action
      t.boolean :checked

      t.timestamps
    end
  end
end
