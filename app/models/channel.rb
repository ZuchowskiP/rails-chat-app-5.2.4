class Channel < ApplicationRecord
  has_many :messages
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

  scope :between, -> (sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  def self.get(sender_id, recipient_id)
    channel = between(sender_id, recipient_id).first
    return channel if channel.present?

    create(sender_id: sender_id, recipient_id: recipient_id)
  end

end
