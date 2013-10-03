class AddBooklistRefToBooks < ActiveRecord::Migration
  def change
    add_reference :books, :booklist, index: true
  end
end
