class FixChannelId < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :channel_id_id
    add_reference :messages, :channel, null: true, foreign_key: { to_table: :channel}
  end
end
