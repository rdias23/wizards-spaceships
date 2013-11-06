class CreateNotificationtypes < ActiveRecord::Migration
  def change
    create_table :notificationtypes do |t|
      t.integer :user_id
      t.boolean :newtopics, default: true
      t.boolean :newcomments, default: true

      t.timestamps
    end
  end
end
