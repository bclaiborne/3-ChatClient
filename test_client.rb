require 'socket'
require_relative 'c_commands.rb'

#Create a socket with our server.
soc = TCPSocket.new 'localhost', 2000
#Create the user
Client.new(soc)
