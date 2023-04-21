class AddGptResponseToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :gpt_response, :text
  end
end
