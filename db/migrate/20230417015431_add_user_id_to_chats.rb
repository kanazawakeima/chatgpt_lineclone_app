class AddUserIdToChats < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :user_id, :integer
  end
end
