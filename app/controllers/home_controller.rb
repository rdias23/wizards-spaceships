class HomeController < ApplicationController
  before_filter :authenticate_user!, except: [:landing]
  def landing
	if !@auth.nil?
		redirect_to(home_index_path)
	end
  end

  def index
	@books = Book.all
	@user = current_user
	@user_books = @user.books
	@top_shelf_books = @user_books[0..7].take(8)
	
	@bottom_shelf_books = @user_books.exists?(8) ? @user_books[9..16].take(8) : [] 


#	@bottom_shelf_books = @user_books[9..16].take(8)
  end

end
