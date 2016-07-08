class AddCreatorToWordDescription < ActiveRecord::Migration[5.0]
  def change
    add_column :word_descriptions, :creator_id, :integer, default: 0, null: false
  end
end
