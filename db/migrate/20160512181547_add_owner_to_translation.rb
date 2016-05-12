class AddOwnerToTranslation < ActiveRecord::Migration[5.0]
  def change
    add_column :translations, :owner_id, :integer, null: false, default: 0
  end
end
