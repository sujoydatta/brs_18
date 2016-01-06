class ReviewsController < ApplicationController
  load_and_authorize_resource

  def create
    @review.user = current_user
    if ReviewService.new(@review).save
      respond_to do |format|
        format.html do
          flash[:success] = t "add_review_sucessful_message"
          redirect_to @review.book
        end
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:danger] = t "add_review_fail_message"
          redirect_to @review.book
        end
        format.js
      end
    end
  end

  def update
    @review.update_attributes review_params
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if ReviewService.new(@review).destroy
      respond_to do |format|
        format.js
      end
    end
  end

  private
  def review_params
    params.require(:review).permit :rating, :content, :book_id
  end
end
