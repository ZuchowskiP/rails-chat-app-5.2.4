class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  scope :family, -> { where(is_family: true) }
  scope :friend, -> { where(is_family: false) }
end
