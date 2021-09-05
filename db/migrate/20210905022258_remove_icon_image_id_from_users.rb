class RemoveIconImageIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :icon_image_id, :string
    remove_column :users, :header_image_id, :string
  end
end
