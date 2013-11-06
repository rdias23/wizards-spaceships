class AddNtkindToNotificationtype < ActiveRecord::Migration
  def change
    add_column :notificationtypes, :ntkind, :string
  end
end
