class FriendshipsController < ApplicationController

  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      if params[:user][:is_family] ==  "1"
        byebug
        current_user.toggle_family(friend.id)
      end
      flash[:success] = "Added #{friend.username} as friend"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to friends_path
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:success] = "Successfully removed friend"
    redirect_to friends_path
  end

end
