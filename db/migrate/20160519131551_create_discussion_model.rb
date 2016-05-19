class CreateDiscussionModel < ActiveRecord::Migration[5.0]
  def change
    create_table :discussions do |t|
      t.text :body, null: false
      t.string :title, default: ""
      t.references :user, foreign_key: true, null: false
      t.integer :parent_id
      t.boolean :hidden, default: false, null: false
      t.boolean :pinned, default: false, null: false
    end
  end
end
