require 'socket.io-client-simple'
#require_relative 'socket.io-client-simple.rb'
                                                   
module WebSocket
  ### Bootstraps all the events for skynet in the correct order. Returns Int.
  def create_socket_events
    #OTHER EVENTS: :identify, :identity, :ready, :disconnect, :message

    create_identify_event
    create_message_event
  end

  #Handles self identification on skynet by responding to the :indentify with a
  #:identity event / credentials Hash.
  def create_identify_event
    $messaging.socket.on :identify do |data|
      self.emit :identity, {
        uuid:     $messaging.uuid,
        token:    $messaging.token,
        socketid: data['socketid']}
      $messaging.identified = true
    end
  end

  ### Routes all skynet messages to handle_event() for interpretation.
  def create_message_event
    #@socket.on :message do |channel, message|
    #  $skynet.handle_message(channel, message)
    #end

    $messaging.socket.on :message do |message|
      $messaging.handle_message(message)
    end
  end

end
