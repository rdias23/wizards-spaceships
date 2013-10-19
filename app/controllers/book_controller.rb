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

    @books_in_book_list_length = @books_in_book_list.length
    
    if @books_in_book_list.include? @book.title
	@book.booklists = @book.booklists - [@booklist]
   	redirect_to :controller => "book", :action => "show"
        notices = ["<strong>BOOK REMOVED!</strong>", "(if bookshelf is open, click \"Update Bookshelf\" button to see change)"]
	flash[:notice] = notices.join("<br/>").html_safe 
    else
     	case @books_in_book_list_length
	   when 0 .. 15 
		@book.booklists << @booklist
      		redirect_to :controller => "book", :action => "show"
		notices = ["BOOK ADDED!", "(if bookshelf is open, click \"Update Bookshelf\" button to see change)"]
		flash[:notice] = notices.join("<br/>").html_safe
	   else
		redirect_to :controller => "book", :action => "show"
		notices = ["BOOKSHELF is already FULL!", "You must remove a book before adding this one!"]
		flash[:notice] = notices.join("<br/>").html_safe
	   end
    end

  end

  def page
	@book = Book.find(params[:id])
	@topics = @book.topics
	@user = current_user
	@topic_number = 1
  end

  def new_topic
	@user = User.find(params[:user_id])
	@book = Book.find(params[:book_id])
	@topic = Topic.create(topic_params)
	@user.topics << @topic
	@book.topics << @topic
	@book_id = params[:book_id]
	redirect_to :controller => "book", :action => "page", :id => @book_id

  end

  private
  def topic_params
    params.require(:topic).permit(:user_id, :book_id, :title, :description, :category)
  end

end
