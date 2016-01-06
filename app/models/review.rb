class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy

  validates :book,
    presence: true,
    uniqueness: {scope: :user}
  validates :content,
    presence: true,
    length: {minimum: 5}

  scope :latest, ->{order updated_at: :desc}
  scope :rate_points, -> book_id{where(book_id: book_id).average "rating"}
  scope :total_rater, -> book_id{count book_id: book_id}

  include PublicActivity::Model
  tracked except: [:destroy],
    owner: ->(controller, model) {controller && controller.current_user}
end
