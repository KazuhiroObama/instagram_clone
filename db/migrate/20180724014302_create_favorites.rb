class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :picture, foreign_key: true

      t.timestamps
    end
    add_index :favorites, [:user_id, :picture_id], unique: true
  end
end
