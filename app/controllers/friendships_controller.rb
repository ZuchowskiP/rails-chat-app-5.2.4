class FriendshipsController < ApplicationController

  def create
    friend = User.find(params[:friend])
    if current_user.add_friend(friend)
      if params[:user][:is_family] == "1"
        current_user.toggle_family(friend.id)
      end
      flash[:success] = "Added #{friend.username}"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to friends_path
  end

  def destroy
    current_user.remove_friend(params[:id])
    flash[:success] = "Successfully removed friend"
    redirect_to friends_path
  end

end
