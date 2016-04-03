class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.string :body, null: false
      t.string :keyword, null: false
      t.integer :language_id, default: 0, null: false
      t.integer :word_class, default: 0, null: false
      t.timestamps
    end
    add_index :words, [:keyword, :language_id]
  end
end
