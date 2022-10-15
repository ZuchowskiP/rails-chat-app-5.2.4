class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel, optional: true, class_name: "Channel"
  validates :body, presence: true
  scope :all_chat, -> { where(channel_id: nil).order(:created_at).last(20) }
  scope :private_last_20, -> { order(:created_at).last(20) }
end
