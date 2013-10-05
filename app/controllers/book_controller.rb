class BookController < ApplicationController
  def index
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user 
  end

  def update
    @book = Book.find(params[:id])
    @booklist = Booklist.find(params[:booklist_id])
    @book.booklists << @booklist
    redirect_to :controller => "home", :action => "index"
	 flash[:notice] = "book added"
  end
end
