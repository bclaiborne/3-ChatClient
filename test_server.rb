require 'socket'
require_relative 's_commands.rb'

server = Server.new

loop do
	#Start a thread for the connection
	Thread.start(server.socket.accept) do |client|    # Wait for a client to connect
        puts "Incoming Connection..."
        #Tokenize the incoming message.
        data = client.gets.split(" ")
        screen_name = data[1].strip
        #Reject illegal connections
        if data[0].strip != "CONNECT"
            client.puts "Use 'CONNECT username' to start a session."
            Thread.kill self
        end
        
        #Add the user to the list
        server.connect(screen_name, client)
        client.puts "-> CONNECTED" 
        #Enter the chat loop
        loop do
			#Get a message
			msg = client.gets
			puts "Message Received"
			if msg.strip == "DISCONNECT"
				puts "discon request"
                client.puts "DISCONNECTED"
                server.del_user(client)
                client.close
                Thread.kill self
            end
			#Parse and return the server message
			response = server.parse(msg)
            puts "My Response: " + response
			client.puts response
		end
	end
	#Send Messages to all connected users.
	
	#loop through all open threads to send
end
