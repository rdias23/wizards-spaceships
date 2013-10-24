class ChangeRatingThemeForBook < ActiveRecord::Migration
  change_table :books do |t|  
        t.change :rating_theme, :float
  end
end
