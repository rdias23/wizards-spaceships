class ChangeRatingPlotForRating < ActiveRecord::Migration
  change_table :ratings do |t|  
        t.change :rating_plot, :float
  end
end
