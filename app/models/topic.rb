class Topic < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :comments
  has_many :comment2s, :through => :comments
  has_many :comment3s, :through => :comment2s
  has_many :users
  has_many :votetps

end
