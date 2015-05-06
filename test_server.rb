require 'socket'
require_relative 's_commands.rb'

server = Server.new

loop do
	#Start a thread for the connection
	Thread.start(server.socket.accept) do |client|    # Wait for a client to connect
		loop do
			#Get a message
			msg = client.gets
			puts msg
			#Parse and return the server message
			response = server.parse(msg, client)
			client.puts response
			if response == "DISCONNECTED"
				#close the socket.
				puts "Client Disconnected."
				client.close
			end
		end
	end
	#Send Messages to all connected users.
	
	#loop through all open threads to send
end
