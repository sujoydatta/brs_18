class AddImageToBookPhotos < ActiveRecord::Migration
  def change
    add_column :book_photos, :image, :string
  end
end
