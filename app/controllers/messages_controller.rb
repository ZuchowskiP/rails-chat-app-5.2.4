class MessagesController < ApplicationController
  before_action :require_user

  def create
    message = current_user.messages.build(message_params)
    if message.save
      ActionCable.server.broadcast "chatroom_channel",
                                   global: true,
                                   mod_msg: message_render(message)
    end
  end

  def message_private
    @friend = User.find(params[:friend])
    channel = Channel.get(current_user, @friend)
    message = Message.new(user_id: current_user.id, body: params[:message][:body])
    if channel.messages << message
      ActionCable.server.broadcast "chatroom_channel",
                                   global: true,
                                   mod_msg: message_render(message)
    end

  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_params_private
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: 'message', locals: { message: message})
  end

  def private_message(sender, recipient, body)
    Message.new(body: body, user_id: sender, recipient: User.find(recipient))
  end

end
