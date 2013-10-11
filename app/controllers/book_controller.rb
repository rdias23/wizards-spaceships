class BookController < ApplicationController
  layout 'colorbox'
  def index
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user 
    @booklist = Booklist.find(@user.booklist.id)
    
    @books_in_book_list = [] 
    
    @booklist.books.each do |bk|
    	@books_in_book_list << bk.title
    end
		 
    if @books_in_book_list.include? @book.title
        @button_label = "Remove Book from Bookshelf?"
    else
	@button_label = "Add Book To Bookshelf?"  
    end

  end

  def update
    @book = Book.find(params[:id])
    @booklist = Booklist.find(params[:booklist_id])
   
    @books_in_book_list = []

    @booklist.books.each do |bk|
        @books_in_book_list << bk.title
    end
    
    if @books_in_book_list.include? @book.title
	@book.booklists = @book.booklists - [@booklist]
   	redirect_to :controller => "book", :action => "show"
        flash[:notice] = "book removed!" 
    else
    	@book.booklists << @booklist
    	redirect_to :controller => "book", :action => "show"
	 flash[:notice] = "book added!"
    end
  end
end
