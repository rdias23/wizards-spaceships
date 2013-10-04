class BookController < ApplicationController
  def index
  end

  def show
    @book = Book.find(params[:id])
  end
end
