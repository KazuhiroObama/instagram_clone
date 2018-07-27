class CreateIcons < ActiveRecord::Migration[5.1]
  def change
    create_table :icons do |t|
      t.string :thumbnail
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
