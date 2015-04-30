require 'socket'
require_relative 's_commands.rb'


users = UserList.new()

loop do
  client = server.accept    # Wait for a client to connect
	connect()
#  client.puts "Hello !"
#  client.puts "Time is #{Time.now}"
end

