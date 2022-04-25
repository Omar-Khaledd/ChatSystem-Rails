class AddNumberToChatsMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :number, :integer, null: false, unique: true
    add_column :messages, :number, :integer, null: false, unique: true
  end
end
