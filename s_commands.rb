
class Server
	attr_accessor :socket
	
	socket = TCPServer.new 2000 # Server bound to port 2000

end
class UserList
	attr_accessor :users
	
	def initialize
		@users = []
	end
	def check_user(target)
		@users.each do |usr|
			return true if usr == target
		end
		false
	end
	def add_user(name)
		@users<<name
	end
	def del_user(target)
		@users.delete(target)
	end
end
def connect
	if command == CONNECT
		client.puts "CONNECTED"
	else 
		client.puts "FAILED"
	end
end
def broadcast
	client.puts "SENT"
end
def send(username, message)
	if username
	client.puts "SENT"
end
def users
	client.puts "USERS #{user_list}"
end
def disconn
	client.puts "DISCONNECTED"
  client.close
end