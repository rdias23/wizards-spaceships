class CreateComment2s < ActiveRecord::Migration
  def change
    create_table :comment2s do |t|
      t.text :title
      t.text :content
      t.integer :user_id
      t.integer :comment_id
      t.integer :topic_id

      t.timestamps
    end
  end
end
