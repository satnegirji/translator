class AddOwnerToWord < ActiveRecord::Migration[5.0]
  def change
    add_column :words, :owner_id, :integer, null: false, default: 0
  end
end
