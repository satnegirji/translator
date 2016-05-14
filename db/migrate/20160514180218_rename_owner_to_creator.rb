class RenameOwnerToCreator < ActiveRecord::Migration[5.0]
  def change
    rename_column :words, :owner_id, :creator_id
    rename_column :translations, :owner_id, :creator_id
  end
end
