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
	
	@bottom_shelf_books = @user_books[8] != nil ? @user_books[8..15].take(8) : [] 


#	@bottom_shelf_books = @user_books[9..16].take(8)

	@notificationct = @user.notificationct


	@topics = []
	@comments = []
	@comment2s = []
	@comment3s = []
	@notification_area_array = []
	
	@user_books.each do |ub| 
		ub.topics.each do |ubtp| 
			@topics << ubtp			
		end

		ub.comments.each do |ubcm| 
                        @comments << ubcm
		end
		
		ub.comments.each do |ubcm2| 
                        @comment2s << ubcm2
		end

		ub.comments.each do |ubcm3| 
                        @comment3s << ubcm3
		end
	end


	@topics.each { |tp| @notification_area_array << tp }
	@comments.each { |tp| @notification_area_array << tp }
	@comment2s.each { |tp| @notification_area_array << tp }
	@comment3s.each { |tp| @notification_area_array << tp }

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


        @topics = []
        @comments = []
        @comment2s = []
        @comment3s = []
        @notification_area_array = []

        @user_books.each do |ub|
                ub.topics.each do |ubtp|
                        @topics << ubtp
                end

                ub.comments.each do |ubcm|
                        @comments << ubcm
                end

                ub.comments.each do |ubcm2|
                        @comment2s << ubcm2
                end

                ub.comments.each do |ubcm3|
                        @comment3s << ubcm3
                end 
        end 


        @topics.each { |tp| @notification_area_array << tp }
        @comments.each { |tp| @notification_area_array << tp }
        @comment2s.each { |tp| @notification_area_array << tp }
        @comment3s.each { |tp| @notification_area_array << tp }

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
end
