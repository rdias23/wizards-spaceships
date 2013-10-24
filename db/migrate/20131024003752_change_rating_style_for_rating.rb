class ChangeRatingStyleForRating < ActiveRecord::Migration
  change_table :ratings do |t|  
        t.change :rating_style, :float
  end
end
