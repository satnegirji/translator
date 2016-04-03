class CreateTranslations < ActiveRecord::Migration[5.0]
  def change
    create_table :translations do |t|
      t.integer :original_id, null: false
      t.integer :translation_id, null: false
      t.timestamps
    end
    add_index :translations, [:original_id, :translation_id]
  end
end
