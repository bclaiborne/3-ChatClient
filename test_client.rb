require 'socket'
require_relative 'c_commands.rb'

soc = TCPSocket.new 'localhost', 2000
#Connect to server
#-Pass Username
#-On CONNECTED response, enter chat mode.
puts "SAY SOMETHING!!"
inp = $stdin.read
puts inp

#while line = soc.gets # Read lines from socket
#  puts line         # and print them
#end

#loop do
#end