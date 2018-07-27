class DropUserPictureFavorite < ActiveRecord::Migration[5.1]
  def change
    drop_table :user_picture_favorites
  end
end
