class SetCountsDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column_default :applications, :chats_count, 0
    change_column_default :chats, :messages_count, 0
  end
end
