class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :rating_style
      t.integer :rating_plot
      t.integer :rating_theme
      t.integer :rating_characters

      t.timestamps
    end
  end
end
