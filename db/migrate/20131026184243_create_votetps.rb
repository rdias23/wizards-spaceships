class CreateVotetps < ActiveRecord::Migration
  def change
    create_table :votetps do |t|
      t.integer :user_id
      t.integer :topic_id
      t.string :up_or_down

      t.timestamps
    end
  end
end
