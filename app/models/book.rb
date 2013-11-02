class Book < ActiveRecord::Base
  has_and_belongs_to_many :booklists
  has_many :users, :through => :booklists
  has_many :topics
  has_many :comments, :through => :topics
  has_many :comment2s, :through => :comments
  has_many :comment3s, :through => :comment2s
  has_many :suggested_books
  has_many :ratings

end
