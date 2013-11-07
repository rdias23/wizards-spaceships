class AddNtkindToNotificationtype < ActiveRecord::Migration
  def change
    add_column :notificationtypes, :ntkind, :string, default: "both"
  end
end
