class ChangeRatingStyleForBook < ActiveRecord::Migration
  change_table :books do |t|  
        t.change :rating_style, :float 
  end
end
