class ChangeRatingThemeForRating < ActiveRecord::Migration
  change_table :ratings do |t|  
        t.change :rating_theme, :float
  end
end
