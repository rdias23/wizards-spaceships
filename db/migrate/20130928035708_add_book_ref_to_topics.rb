class AddBookRefToTopics < ActiveRecord::Migration
  def change
    add_reference :topics, :book, index: true
  end
end
