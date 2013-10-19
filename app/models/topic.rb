class Topic < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :comments
  has_many :users

end
