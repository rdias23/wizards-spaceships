class CreateSorttypes < ActiveRecord::Migration
  def change
    create_table :sorttypes do |t|
      t.integer :user_id
      t.string :skind, default: "npr"
      t.string :direction, default: "forward"

      t.timestamps
    end
  end
end
