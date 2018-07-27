class AddThumbnailIndexToIcons < ActiveRecord::Migration[5.1]
  def change
    change_column_null :icons, :thumbnail, false
  end
end
