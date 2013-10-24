class ChangeRatingPlotForBook < ActiveRecord::Migration
  change_table :books do |t|  
        t.change :rating_plot, :float
  end
end
