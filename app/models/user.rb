class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 15}
  has_many :messages
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :channels, foreign_key: :sender_id
  has_secure_password

  def add_friend(friend)
    self.friends << friend
    friend.friends << self
  end

  def remove_friend(friend_id)
    friendship = get_friendship(friend_id)
    friendship.each do |f|
      f.destroy
    end
  end

  def toggle_family(friend_id)
    friendship = get_friendship(friend_id)
    friendship.each do |f|
      f.is_family = !f.is_family
      f.save
    end
  end

  def self.search(param)
    param.strip!
    to_send_back = where("username like ?", "%#{param}%").uniq
    to_send_back
  end

  def except_current_user(users)
    users.reject{ |user| user.id == self.id}
  end

  def is_family
  end

  def not_friends_with?(friend_id)
    !self.friends.where(id: friend_id).exists?
  end

  def get_family
    family = Friendship.where(user_id: self.id).family.all
    fam = []
    family.each do |f|
      fam << User.find(f.friend_id)
    end
    fam
  end

  def get_friends
    friends = Friendship.where(user_id: self.id).friend.all
    fri = []
    friends.each do |f|
      fri << User.find(f.friend_id)
    end
    fri
  end

  def get_friendship(friend_id)
    Friendship.where(user_id: self.id, friend_id: friend_id).or(Friendship.where(user_id: friend_id, friend_id:self.id))
  end

end
