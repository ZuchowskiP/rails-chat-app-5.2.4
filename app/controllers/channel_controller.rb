class ChannelController < ApplicationController

  def private_channel
    @channel = Channel.get(current_user.id, params[:friend])
    @friend = User.find(params[:friend])
    @messages = @channel.messages.private_last_20
    @message = Message.new
  end

end
