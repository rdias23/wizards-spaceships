class Comment3 < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  belongs_to :comment
  belongs_to :comment2
end
