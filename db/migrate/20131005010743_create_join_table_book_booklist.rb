class CreateJoinTableBookBooklist < ActiveRecord::Migration
  def change
    create_join_table :books, :booklists do |t|
      # t.index [:book_id, :booklist_id]
      # t.index [:booklist_id, :book_id]
    end
  end
end
