class Admin::BooksController < ApplicationController
  load_and_authorize_resource

  def new
    @categories = Category.all
  end

  def create
    if @book.save
      flash[:success] = t "book_added_text"
      redirect_to request.referrer
    else
      render :new
    end
  end

  private
  def book_params
    params.require(:book).permit :category_id, :title, :author, :publish_date,
      :page, book_photos_attributes: [:id, :image, :_destroy]
  end
end
