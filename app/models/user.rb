class User < ActiveRecord::Base
  has_one :booklist
  has_many :topics
  has_many :comments
  has_many :books, :through => :booklist
  has_many :suggested_books

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :create_booklist

  def create_wishlist
    Wishlist.create(user_id: self.id)
  end
end
