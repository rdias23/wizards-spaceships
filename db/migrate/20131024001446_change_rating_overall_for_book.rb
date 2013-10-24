class ChangeRatingOverallForBook < ActiveRecord::Migration
  change_table :books do |t|  
        t.change :rating_overall, :float
  end
end
