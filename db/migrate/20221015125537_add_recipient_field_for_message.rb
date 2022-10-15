class AddRecipientFieldForMessage < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :recipient, null: true, foreign_key: { to_table: :user}
  end
end
