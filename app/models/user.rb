class User < ActiveRecord::Base
  has_one :booklist
  has_many :topics
  has_many :comments
  has_many :comment2s
  has_many :comment3s
  has_many :books, :through => :booklist
  has_many :suggested_books
  has_many :ratings
  has_many :votetps
  has_one :notificationct

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  after_create :create_booklist
  after_create :create_notificationct

  def create_notificationct
    Notificationct.create(user_id: self.id)
  end



end
