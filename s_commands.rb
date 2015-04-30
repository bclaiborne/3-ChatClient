
class Server
	attr_accessor :socket, :users
	
	def initialize
		@socket = TCPServer.new 2000 # Server bound to port 2000
		@users = UserList.new()
	end
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

def connect(command)
	if command == "CONNECT"
		return "CONNECTED"
	else 
		return "FAILED"
	end
end
def broadcast
	client.puts "SENT"
end
def send(username, message)
	if username
	client.puts "SENT"
	end
end
def users
	client.puts "USERS #{user_list}"
end
def disconn
	client.puts "DISCONNECTED"
  client.close
end