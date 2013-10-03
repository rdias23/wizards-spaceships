class CreateSuggestedBooks < ActiveRecord::Migration
  def change
    create_table :suggested_books do |t|
      t.string :title
      t.string :author

      t.timestamps
    end
  end
end
