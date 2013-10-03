class CreateBooklists < ActiveRecord::Migration
  def change
    create_table :booklists do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
