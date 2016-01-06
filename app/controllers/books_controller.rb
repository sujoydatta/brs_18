class BooksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @categories = Category.all
    @search = Book.search params[:q]
    @books = @search.result.latest.page(params[:page]).per 10
  end

  def show
    @review = @book.reviews.build
    @reviews = @book.reviews.latest
    @comment = current_user.comments.build
    @user_book = UserBook.find_or_create_by user_id: current_user.id,
      book_id: @book.id
    @total_reviewer = Review.total_rater @book.id
  end
end
