class CreateNotificationcts < ActiveRecord::Migration
  def change
    create_table :notificationcts do |t|
      t.integer :user_id
      t.datetime :time
      t.integer :days, default: 3

      t.timestamps
    end
  end
end
