class ChannelController < ApplicationController

  def private_channel
    @channel = Channel.get(current_user.id, params[:friend])
    @messages = @channel.messages
    @message = Message.new
  end

end
