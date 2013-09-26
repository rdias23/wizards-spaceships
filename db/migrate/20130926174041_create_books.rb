class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.text :description
      t.string :picture
      t.date :publication
      t.integer :rating_style
      t.integer :rating_plot
      t.integer :rating_theme
      t.integer :rating_characters
      t.integer :rating_overall

      t.timestamps
    end
  end
end
