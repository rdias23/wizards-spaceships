class AddBookRefToSuggestedBooks < ActiveRecord::Migration
  def change
    add_reference :suggested_books, :book, index: true
  end
end
