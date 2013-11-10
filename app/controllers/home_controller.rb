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
	@sorttype = @user.sorttype
	@sorttype.direction = "first-forward-npr"
	@sorttype.save
	@user_books = @user.books
	@top_shelf_books = @user_books[0..7].take(8)
	
	@bottom_shelf_books = @user_books[8] != nil ? @user_books[8..15].take(8) : [] 


#	@bottom_shelf_books = @user_books[9..16].take(8)

	@notificationct = @user.notificationct
	@notificationtype = @user.notificationtype

	@topics = []
	@comments = []
	@comment2s = []
	@comment3s = []
	@comment_reply_array = []
	@comment2_reply_array = []
	@topic_reply_array = []

	@notification_area_array = []
	
	@user_books.each do |ub| 
		ub.topics.each do |ubtp| 
			@topics << ubtp			
		end

		ub.comments.each do |ubcm| 
                        @comments << ubcm
			if (ubcm.topic.user_id == @user.id)
				@topic_reply_array << ubcm
			end
		end
		
		ub.comment2s.each do |ubcm2| 
                        @comment2s << ubcm2
			if (ubcm2.comment.user_id == @user.id)
				@comment_reply_array << ubcm2
			end	
		end

		ub.comment3s.each do |ubcm3| 
                        @comment3s << ubcm3
			if (ubcm3.comment2.user_id == @user.id)
                                @comment2_reply_array << ubcm3
                        end
		end
	end


	if (@notificationtype.newtopics == true && @notificationtype.newcomments == true)
		@topics.each { |tp| @notification_area_array << tp }
		@comments.each { |tp| @notification_area_array << tp }
		@comment2s.each { |tp| @notification_area_array << tp }
		@comment3s.each { |tp| @notification_area_array << tp }
	elsif (@notificationtype.newtopics == true && @notificationtype.newcomments == false)
		@topics.each { |tp| @notification_area_array << tp }
	elsif (@notificationtype.newtopics == false && @notificationtype.newcomments == true)
		@comments.each { |tp| @notification_area_array << tp }
                @comment2s.each { |tp| @notification_area_array << tp }
                @comment3s.each { |tp| @notification_area_array << tp }
	else
	end

	@notificationct.time = (@notificationct.days).days.ago
	@notification_area_array_filtered = []

	@notification_area_array.each do |naa|
		if(naa.created_at >= @notificationct.time)
			@notification_area_array_filtered << naa
		end	
	end

	@notification_area_array_filtered_and_sorted = @notification_area_array_filtered.sort_by{|e| e[:created_at]}.reverse
  end


  def update_side_menu
        @user = current_user
        @user_books = @user.books
        @top_shelf_books = @user_books[0..7].take(8)

        @bottom_shelf_books = @user_books[8] != nil ? @user_books[8..15].take(8) : []

	@notificationct = @user.notificationct
	@notificationtype = @user.notificationtype

	if(params.has_key?(:notificationct))
		@notificationct.update_attributes!(notificationct_params)
	end

	if(params.has_key?(:notificationtype))
                @notificationtype.update_attributes!(notificationtype_params)
       		case @notificationtype.ntkind
		when "both"
			@notificationtype.newtopics = true
			@notificationtype.newcomments = true
		when "topics"
			@notificationtype.newtopics = true
                        @notificationtype.newcomments = false
		when "comments"
			@notificationtype.newtopics = false
                        @notificationtype.newcomments = true
		else
		end
		@notificationtype.save
	end

        @topics = []
        @comments = []
        @comment2s = []
        @comment3s = []
	@comment_reply_array = []
        @comment2_reply_array = []
        @topic_reply_array = []

        @notification_area_array = []

        @user_books.each do |ub|
                ub.topics.each do |ubtp|
                        @topics << ubtp
                end

                ub.comments.each do |ubcm|
                        @comments << ubcm
			if (ubcm.topic.user_id == @user.id)
                                @topic_reply_array << ubcm
                        end
                end

                ub.comment2s.each do |ubcm2|
                        @comment2s << ubcm2
			if (ubcm2.comment.user_id == @user.id)
                                @comment_reply_array << ubcm2
                        end
                end

                ub.comment3s.each do |ubcm3|
                        @comment3s << ubcm3
			if (ubcm3.comment2.user_id == @user.id)
                                @comment2_reply_array << ubcm3
                        end
                end 
        end 


	if (@notificationtype.newtopics == true && @notificationtype.newcomments == true)
                @topics.each { |tp| @notification_area_array << tp }
                @comments.each { |tp| @notification_area_array << tp }
                @comment2s.each { |tp| @notification_area_array << tp }
                @comment3s.each { |tp| @notification_area_array << tp }
        elsif (@notificationtype.newtopics == true && @notificationtype.newcomments == false)
                @topics.each { |tp| @notification_area_array << tp }
        elsif (@notificationtype.newtopics == false && @notificationtype.newcomments == true)
                @comments.each { |tp| @notification_area_array << tp }
                @comment2s.each { |tp| @notification_area_array << tp }
                @comment3s.each { |tp| @notification_area_array << tp }
        else
        end

        @notificationct.time = (@notificationct.days).days.ago
        @notification_area_array_filtered = []

        @notification_area_array.each do |naa|
                if(naa.created_at >= @notificationct.time)
                        @notification_area_array_filtered << naa 
                end         
        end 

        @notification_area_array_filtered_and_sorted = @notification_area_array_filtered.sort_by{|e| e[:created_at]}.reverse

    respond_to do | format |  
        format.js {render :layout => false}  
    end
  end

  def update_gallery
    	@books = Book.all
    	@user = current_user
    	@sorttype = @user.sorttype
    	@user_books = @user.books
    	@top_shelf_books = @user_books[0..7].take(8)

    	@bottom_shelf_books = @user_books[8] != nil ? @user_books[8..15].take(8) : []    

        @sorttype.update_attributes!(sorttype_params)

	if (@sorttype.skind == "npr")
		case @sorttype.direction
		when "backward-npr"
                	@books = @books.sort_by{|e| e[:rank]}.reverse
                	@sorttype.direction = "forward"
                	@sorttype.save
		when "first-forward-npr"
			@books = @books.sort_by{|e| e[:rank]}.reverse
                        @sorttype.direction = "forward"
                        @sorttype.save	
		else
			@books = @books.sort_by{|e| e[:rank]}
			@sorttype.direction = "backward-npr"
                        @sorttype.save
		end
	elsif (@sorttype.skind == "title") 
                case @sorttype.direction 
                when "backward-title"
                        @books = @books.sort_by{|e| e[:title]}.reverse
                        @sorttype.direction = "forward"
                        @sorttype.save  
                else
                        @books = @books.sort_by{|e| e[:title]}
                        @sorttype.direction = "backward-title"
                        @sorttype.save
                end
        elsif (@sorttype.skind == "author")
                case @sorttype.direction
                when "backward-author"
                        @books = @books.sort_by{|e| e[:lastname]}.reverse
                        @sorttype.direction = "forward"
                        @sorttype.save
                else
                        @books = @books.sort_by{|e| e[:lastname]}
                        @sorttype.direction = "backward-author"
                        @sorttype.save
                end
        elsif (@sorttype.skind == "publication")
                case @sorttype.direction
                when "backward-publication"
                        @books = @books.sort_by{|e| e[:publication]}.reverse
                        @sorttype.direction = "forward"
                        @sorttype.save
                else
                        @books = @books.sort_by{|e| e[:publication]}
                        @sorttype.direction = "backward-publication"
                        @sorttype.save
                end
        elsif (@sorttype.skind == "rating")
                case @sorttype.direction
                when "backward-rating"
                        @books = @books.compact.sort_by{|e| e[:rating_overall] || 0.0 }
                        @sorttype.direction = "forward"
                        @sorttype.save
                else
                        @books = @books.sort_by{|e| e[:rating_overall] || 0.0 }.reverse
                        @sorttype.direction = "backward-rating"
                        @sorttype.save
                end
	else
	end

    respond_to do |format|
	format.js {render :layout => false}
    end
  end
  

  def notificationct_params
    params.require(:notificationct).permit(:days)
  end

  def notificationtype_params
    params.require(:notificationtype).permit(:ntkind)
  end

  def sorttype_params
    params.permit(:skind, :user_id, :id)
  end
  
end
