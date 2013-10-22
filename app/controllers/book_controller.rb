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
	
	@user.ratings.where(book_id: @book.id).exists? && @user.ratings.where(book_id: @book.id)[0].rating_style != nil ? @current_style_rt = @user.ratings.where(book_id: @book.id)[0].rating_style : @current_style_rt = "none"
	@user.ratings.where(book_id: @book.id).exists? && @user.ratings.where(book_id: @book.id)[0].rating_plot != nil ? @current_plot_rt = @user.ratings.where(book_id: @book.id)[0].rating_plot : @current_plot_rt = "none"
	@user.ratings.where(book_id: @book.id).exists? && @user.ratings.where(book_id: @book.id)[0].rating_theme != nil ? @current_theme_rt = @user.ratings.where(book_id: @book.id)[0].rating_theme : @current_theme_rt = "none"
	@user.ratings.where(book_id: @book.id).exists? && @user.ratings.where(book_id: @book.id)[0].rating_characters != nil ? @current_characters_rt = @user.ratings.where(book_id: @book.id)[0].rating_characters : @current_characters_rt = "none"

	if @user.ratings.where(book_id: @book.id).exists?
		@button_label_2 = "Re-Rate Book!"
	else	
		@button_label_2 = "Rate Book!"
	end

	@ratings_plot = [1, 2, 3, 4, 5]
	@ratings_theme = [1, 2, 3, 4, 5]
	@ratings_characters = [1, 2, 3, 4, 5]
	@ratings_style = [1, 2, 3, 4, 5]



	@averaged_style_rating_array = []
        @averaged_plot_rating_array = []
        @averaged_theme_rating_array = []
        @averaged_characters_rating_array = []

        @book.ratings.each do |rt|
                if rt.rating_style != nil
                        @averaged_style_rating_array << rt.rating_style
                end
                if rt.rating_plot != nil
                        @averaged_plot_rating_array << rt.rating_plot
                end
                if rt.rating_theme != nil
                        @averaged_theme_rating_array << rt.rating_theme
                end
                if rt.rating_characters != nil
                        @averaged_characters_rating_array << rt.rating_characters
                end
        end

        @averaged_style_rating_array.length > 0 ? (@book.rating_style = (@averaged_style_rating_array.inject{|sum,x| sum + x}) / @averaged_style_rating_array.length) : (@book.rating_style = "no ratings")
        @averaged_plot_rating_array.length > 0 ? (@book.rating_plot = (@averaged_plot_rating_array.inject{|sum,x| sum + x}) / @averaged_plot_rating_array.length) : (@book.rating_plot = "no ratings")
        @averaged_theme_rating_array.length > 0 ? (@book.rating_theme = (@averaged_theme_rating_array.inject{|sum,x| sum + x}) / @averaged_theme_rating_array.length) : (@book.rating_theme = "no ratings")
        @averaged_characters_rating_array.length > 0 ? (@book.rating_characters = (@averaged_characters_rating_array.inject{|sum,x| sum + x}) / @averaged_characters_rating_array.length) : (@book.rating_characters = "no ratings")

	@book.rating_overall = ((@book.rating_style + @book.rating_plot + @book.rating_theme + @book.rating_characters)/ 4)

	@book_comment_last_created_at = "--"
	@book_comment_last_created_at_topic = "--"
	(@book_comment_last_created_at = @book.comments.last.created_at.to_formatted_s(:short)) if (@book.comments.last != nil)
	(@book_comment_last_created_at_topic = @book.comments.last.topic.title) if (@book.comments.last != nil)
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

  def rate_book
	@book = Book.find(params[:book_id])
	@user = current_user
	@user_id = @user.id
	@current_style_rt = nil
	@current_plot_rt = nil
	@current_theme_rt = nil
	@current_characters_rt = nil

	if @user.ratings.where(book_id: @book.id).exists?
		
		(@current_style_rt = @user.ratings.where(book_id: @book.id)[0].rating_style) if (@user.ratings.where(book_id: @book.id)[0].rating_style != nil)
		(@current_plot_rt = @user.ratings.where(book_id: @book.id)[0].rating_plot) if (@user.ratings.where(book_id: @book.id)[0].rating_plot != nil)
		(@current_theme_rt = @user.ratings.where(book_id: @book.id)[0].rating_theme) if (@user.ratings.where(book_id: @book.id)[0].rating_theme != nil)
		(@current_characters_rt = @user.ratings.where(book_id: @book.id)[0].rating_characters) if (@user.ratings.where(book_id: @book.id)[0].rating_characters != nil)

		@user.ratings.where(book_id: @book.id)[0].destroy
		@rating = Rating.create(rating_params)
		
		(@rating.rating_style = @current_style_rt) if ((@rating.rating_style == nil) && (@current_style_rt != nil))
		(@rating.rating_plot = @current_plot_rt) if ((@rating.rating_plot == nil) && (@current_plot_rt != nil))
		(@rating.rating_theme = @current_theme_rt) if ((@rating.rating_theme == nil) && (@current_theme_rt != nil))
		(@rating.rating_characters = @current_characters_rt) if ((@rating.rating_characters == nil) && (@current_characters_rt != nil))
		
		@user.ratings << @rating
		@book.ratings << @rating
		redirect_to :controller => "book", :action => "page", :id => @book.id
        	flash[:notice] = "Book has been re-rated!"
	else
		@rating = Rating.create(rating_params)
                @user.ratings << @rating
                @book.ratings << @rating
		redirect_to :controller => "book", :action => "page", :id => @book.id
        	flash[:notice] = "Book has been rated!"
	end

	
  end

  private
  def topic_params
    params.require(:topic).permit(:user_id, :book_id, :title, :description, :category)
  end

  def rating_params
    params.require(:book).permit(:book_id, :rating_style, :rating_plot, :rating_theme, :rating_characters)
  end

end
