class ChangeRatingCharactersForRating < ActiveRecord::Migration
  change_table :ratings do |t|  
        t.change :rating_characters, :float
  end
end
