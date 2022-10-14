class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 15}
  has_many :messages
  has_many :friendships
  has_many :friends, through: :friendships
  has_secure_password

  def toggle_family(friend_id)
    friendship = Friendship.where(user_id: self.id, friend_id: friend_id).first
    friendship.is_family = !friendship.is_family
    friendship.save
  end

  def self.search(param)
    param.strip!
    to_send_back = where("username like ?", "%#{param}%").uniq
    to_send_back
  end

  def except_current_user(users)
    users.reject{ |user| user.id == self.id}
  end

  def not_friends_with?(friend_id)
    !self.friends.where(friend_id: friend_id).exists?
  end

  def is_family
  end

end
