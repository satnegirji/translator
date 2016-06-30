class CreateWordDescriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :word_descriptions do |t|
      t.integer :word_id, null: false
      t.text :body, null: false
      t.integer :language_id, null: false

      t.timestamps
    end
    add_index :word_descriptions, [:word_id, :language_id]
  end
end
