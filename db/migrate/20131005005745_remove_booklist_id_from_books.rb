class RemoveBooklistIdFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :booklist_id, :integer
  end
end
