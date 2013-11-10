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
		if(params.has_key?(:created_at))
			redirect_to :controller => "book", :action => "page", :id => @book.id
                	notices = ["<strong>BOOK REMOVED!</strong>", "(if bookshelf is open, click \"Update Bookshelf\" button to see change)"]
                	flash[:notice2] = notices.join("<br/>").html_safe
		else
   			redirect_to :controller => "book", :action => "show"
        		notices = ["<strong>BOOK REMOVED!</strong>", "(if bookshelf is open, click \"Update Bookshelf\" button to see change)"]
			flash[:notice] = notices.join("<br/>").html_safe 
		end
    else
     	case @books_in_book_list_length
	   when 0 .. 15 
		@book.booklists << @booklist
		if(params.has_key?(:created_at))
                        redirect_to :controller => "book", :action => "page", :id => @book.id
                        notices = ["BOOK ADDED!", "(if bookshelf is open, click \"Update Bookshelf\" button to see change)"]
                        flash[:notice2] = notices.join("<br/>").html_safe
		else
			redirect_to :controller => "book", :action => "show"
			notices = ["BOOK ADDED!", "(if bookshelf is open, click \"Update Bookshelf\" button to see change)"]
			flash[:notice] = notices.join("<br/>").html_safe
		end
	   else 
		if(params.has_key?(:created_at))
                        redirect_to :controller => "book", :action => "page", :id => @book.id
                        notices = ["BOOKSHELF is already FULL!", "You must remove a book before adding this one!"]
                        flash[:notice2] = notices.join("<br/>").html_safe
		else
			redirect_to :controller => "book", :action => "show"
			notices = ["BOOKSHELF is already FULL!", "You must remove a book before adding this one!"]
			flash[:notice] = notices.join("<br/>").html_safe
		end
	   end
    end

  end

  def page
	@book = Book.find(params[:id])
	@topics = @book.topics.order('votes DESC')
	@newest_topic = @book.topics.order('created_at DESC').first
	@newest_topic_array = []
	@newest_topic_array << @newest_topic
	@user = current_user
	@topic_number = 1
	
	@booklist = Booklist.find(@user.booklist.id)

    	@books_in_book_list = []

    	@booklist.books.each do |bk|
    	    @books_in_book_list << bk.title
    	end




	if @books_in_book_list.include? @book.title
	        @button_label4 = "Remove Book from Bookshelf?"
        else
	        @button_label4 = "Add Book To Bookshelf?"
        end




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

        @averaged_style_rating_array.length > 0 ? (@book.rating_style = (@averaged_style_rating_array.inject{|sum,x| sum + x}) / @averaged_style_rating_array.length) : (@book.rating_style = nil)
        @averaged_plot_rating_array.length > 0 ? (@book.rating_plot = (@averaged_plot_rating_array.inject{|sum,x| sum + x}) / @averaged_plot_rating_array.length) : (@book.rating_plot = nil)
        @averaged_theme_rating_array.length > 0 ? (@book.rating_theme = (@averaged_theme_rating_array.inject{|sum,x| sum + x}) / @averaged_theme_rating_array.length) : (@book.rating_theme = nil)
        @averaged_characters_rating_array.length > 0 ? (@book.rating_characters = (@averaged_characters_rating_array.inject{|sum,x| sum + x}) / @averaged_characters_rating_array.length) : (@book.rating_characters = nil)

	@rating_overall_array = @averaged_style_rating_array + @averaged_plot_rating_array + @averaged_theme_rating_array + @averaged_characters_rating_array	

	@rating_overall_array.length != 0 ? @book.rating_overall = @rating_overall_array.inject{|sum,x| sum + x} / @rating_overall_array.length : @book.rating_overall = nil

	@book_comment_last_created_at = "--"
	@book_comment_last_created_at_topic = "--"
	(@book_comment_last_created_at = @book.comments.last.created_at.strftime("%B %e, %Y at %I:%M %p")) if (@book.comments.last != nil)
	(@book_comment_last_created_at_topic = @book.comments.last.topic.title.slice!(0..46)) if (@book.comments.last != nil)

	@button_label3 = "View Topic Page"
	@book.save
	
  end

  def new_topic
	@user = User.find(params[:user_id])
	@book = Book.find(params[:book_id])
	@topic = Topic.create(topic_params)
	@topic.votes = 0
	@topic.save
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

  def page_topic
	@topic = Topic.find(params[:id])
	@topic_comments_array = Array.new
	@topic_comment_last = @topic.comments.order('created_at ASC').last
	(@topic_comments_array << @topic_comment_last) if (@topic_comment_last != nil)
	@topic_comment2_last = @topic.comment2s.order('created_at ASC').last
	(@topic_comments_array << @topic_comment2_last) if (@topic_comment2_last != nil)
	@topic_comment3_last = @topic.comment3s.order('created_at ASC').last
	(@topic_comments_array << @topic_comment3_last) if (@topic_comment3_last != nil)

	(@last_comment = @topic_comments_array.sort_by{|e| e[:created_at]}.last) if (@topic_comments_array != [])	

	@book = @topic.book
	@user = current_user
	@button_label = "Post Comment"
  end

  def new_comment
	@user = User.find(params[:user_id])
        @topic = Topic.find(params[:topic_id])
        @comment = Comment.create(comment_params)
        @topic.comments << @comment
        @user.comments << @comment
        @topic_id = params[:topic_id]
        redirect_to :controller => "book", :action => "page_topic", :id => @topic_id
  end

  def new_comment2
        @user = User.find(params[:user_id])
        @topic = Topic.find(params[:topic_id])
	@comment = Comment.find(params[:comment_id])
        @comment2 = Comment2.create(comment2_params)
        @comment.comment2s << @comment2
	@user.comment2s << @comment2
        @topic_id = params[:topic_id]
        redirect_to :controller => "book", :action => "page_topic", :id => @topic_id
  end

  def new_comment3
        @user = User.find(params[:user_id])
        @topic = Topic.find(params[:topic_id])
        @comment2 = Comment2.find(params[:comment2_id])
        @comment3 = Comment3.create(comment3_params)
        @comment2.comment3s << @comment3
        @user.comment3s << @comment3
        @topic_id = params[:topic_id]
        redirect_to :controller => "book", :action => "page_topic", :id => @topic_id
  end

  def vote_topic
        @user = User.find(params[:user_id])
	@topic = Topic.find(params[:topic_id])
	@book = @topic.book

	unless @topic.votetps.where(user_id: @user.id).blank?
		@topic.votetps.where(user_id: @user.id)[0].destroy
	end

	@votetp = Votetp.create([votetp_params])	
	@user.votetps << @votetp
	@topic.votetps << @votetp
	@up_votes = @topic.votetps.where(up_or_down: "up").length
	@down_votes = @topic.votetps.where(up_or_down: "down").length
	@topic.votes = @up_votes - @down_votes
	@topic.save

	@topic_id = params[:topic_id]


	respond_to do |format|
	    format.js {render :layout => false}
	end
  end 

  def add_comment_reply
	@comment = Comment.find(params[:comment_id])
	@button_label = "Post Comment"

	respond_to do |format|
	    format.js {render :layout => false}
	end
  end

  def add_comment2_reply
        @comment2 = Comment2.find(params[:comment2_id])
        @button_label = "Post Comment"

        respond_to do |format|
            format.js {render :layout => false}
        end
  end


  private
  def topic_params
    params.require(:topic).permit(:user_id, :book_id, :title, :description, :category)
  end

  def rating_params
    params.require(:book).permit(:book_id, :rating_style, :rating_plot, :rating_theme, :rating_characters)
  end

  def comment_params
    params.require(:comment).permit(:user_id, :topic_id, :content)
  end

  def comment2_params
    params.require(:comment2).permit(:user_id, :topic_id, :comment_id, :content)
  end

  def comment3_params
    params.require(:comment3).permit(:user_id, :topic_id, :comment2_id, :content)
  end

  def votetp_params
    params.permit(:user_id, :topic_id, :up_or_down)
  end

end
