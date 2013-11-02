class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :comment2s
  has_many :comment3s, :through => :comment2s
end
