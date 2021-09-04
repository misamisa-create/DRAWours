class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      t.string :title
      t.text :text
      t.string :image_id, null: false
      t.integer :making_time
      t.string :instrument

      t.timestamps
    end
  end
end
