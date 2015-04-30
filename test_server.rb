require 'socket'
require_relative 's_commands.rb'

server = Server.new


loop do
  Thread.start(server.socket.accept) do |client|    # Wait for a client to connect
	  loop do
		  command = client.gets
		  client.puts connect(command.strip)
		  client.puts command
	  end
  end
end

#TCP Server ThreadThreadThread