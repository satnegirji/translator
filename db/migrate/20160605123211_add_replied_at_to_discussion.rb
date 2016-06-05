class AddRepliedAtToDiscussion < ActiveRecord::Migration[5.0]
  def change
    add_column :discussions, :replied_at, :datetime
  end
end
