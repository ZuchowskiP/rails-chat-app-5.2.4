class RemoveRecipientFromColumnAddChannelId < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :recipient_id
    add_reference :messages, :channel_id, null: true, foreign_key: { to_table: :channel}
  end
end
