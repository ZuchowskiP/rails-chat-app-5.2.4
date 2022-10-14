class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
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
