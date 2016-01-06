class ReviewService
  def initialize review
    @review = review
    @book = Book.find @review.book.id
  end

  def save
    if @review.save
      calculate_rating
      true
    else
      false
    end
  end

  def destroy
    if @review.valid?
      @review.destroy
      calculate_rating
      true
    else
      false
    end
  end

  private
  def calculate_rating
    if Review.rate_points(@book.id).class == BigDecimal
      @book.update_attributes rating: Review.rate_points(@book.id).round
    else
      @book.update_attributes rating: 0
    end
  end

end