require 'socket'
require_relative 's_commands.rb'

server = Server.new

loop do
	#Start a thread for the connection
	thread = Thread.start(server.socket.accept) do |client|    # Wait for a client to connect
        puts "Incoming Connection..."
        loop do
            #Don't process if the connection has been closed.
            if !client.closed?
                #Tokenize the incoming message.
                data = client.gets.split(" ")

                if data[0].strip == "DISCONNECT"
                    puts "Discon Request"
                    #Respond from the disconnect
                    response = server.disconn(client)
                    #close the socket
                    client.close
                else
                    #Parse and return the server message
                    response = server.parse(data, client)
                    client.puts response
                end
            end
		end
	end
    #Rejoin the main thread so we can loop commands.
    thread.join
end
