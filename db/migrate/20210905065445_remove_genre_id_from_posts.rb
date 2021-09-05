class RemoveGenreIdFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :genre_id, :integer
  end
end
