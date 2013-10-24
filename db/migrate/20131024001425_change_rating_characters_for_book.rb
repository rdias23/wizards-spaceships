class ChangeRatingCharactersForBook < ActiveRecord::Migration
  change_table :books do |t|  
        t.change :rating_characters, :float
  end
end
