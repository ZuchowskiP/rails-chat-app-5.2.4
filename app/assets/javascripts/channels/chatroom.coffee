jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0

    App.chatroom = App.cable.subscriptions.create {
      channel: "ChatroomChannel"
      chat_room_id: messages.data('room-id')
    },


    connected: ->
    # Called when the subscription is ready for use on the server

    disconnected: ->
    # Called when the subscription has been terminated by the server

    received: (data) ->
      $('#message-container').append data.mod_msg
      scroll_bottom()
