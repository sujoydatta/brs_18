class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def update
    @user_book = UserBook.find_by params[:id]
    @user_book.update_attributes book_params
    redirect_to @user_book.book
    respond_to do |format|
      format.js
    end
  end

  private
  def book_params
    params.require(:user_book).permit :favourite
  end
end
