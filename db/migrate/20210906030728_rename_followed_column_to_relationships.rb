class RenameFollowedColumnToRelationships < ActiveRecord::Migration[5.2]
  def change
    rename_column :relationships, :followed, :followed_id

  end
end
