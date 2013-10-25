class ChangeTitleForComment < ActiveRecord::Migration
  change_table :comments do |t|  
        t.change :title, :text
  end
end
