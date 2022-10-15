class FriendsController < ApplicationController
  def index
    @friends = current_user.get_friends
    @family = current_user.get_family
  end

  def toggle_family
    if params[:friend].present?
      friend = User.find(params[:friend])
      current_user.toggle_family(friend.id)
      flash[:success] = "Changed family status with user #{friend.username}"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to friends_path
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends.length != 0
        respond_to do |format|
          format.js { render partial: 'friends/friend_result'}
        end
      elsif @friends
        respond_to do |format|
          flash.now[:error] = "No user found with username containing #{params[:friend]}"
          format.js { render partial: 'friends/friend_result'}
        end
      end

    else
      respond_to do |format|
        flash.now[:error] = "Please enter a username to search"
        format.js { render partial: 'friends/friend_result'}
      end

    end
  end

end
