class Book < ActiveRecord::Base
  has_and_belongs_to_many :booklists
  has_many :topics
  has_many :comments, :through => :topics
  has_many :suggested_books

end
