class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :category
      t.text :description
      t.integer :votes

      t.timestamps
    end
  end
end
