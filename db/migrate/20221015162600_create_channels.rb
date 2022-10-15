class CreateChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :channels do |t|
      t.integer :recipient_id
      t.integer :sender_id

      t.timestamps
    end
    add_index :channels, :recipient_id
    add_index :channels, :sender_id
    add_index :channels, [:recipient_id, :sender_id], unique: true
  end
end
