class Server
	attr_accessor :socket, :users
	
	def initialize
		@socket = TCPServer.new 2000 # Server bound to port 2000
		@users = UserList.new()
	end
	def parse(msg, client)
		#Pull the message out
		#message = msg
		tokens = msg.strip.split(" ")
		command = tokens[0].strip
puts command
		case command
			when "CONNECT"
				puts "connect request"
				response = connect(tokens[1], client)
			when "BROADCAST"
				puts "broadcast request"
				response = broadcast(tokens[1])
			when "SEND"
				puts "send request"
				response = send(tokens[1], tokens[2])
			when "USERLIST"
				puts "userlist request"
				response = userlisting()
			when "DISCONNECT"
				puts "discon request"
			#need to figur out how to grab the user.
				response = disconn(client)
			else
			response = "I don't know what #{tokens[0]} means." 
#				Useful commands:
#				CONNECT username | 
#				BROADCAST message_line | 
#				SEND username message_line |
#				USERLIST |
#				DISCONNECT." */
		end
		return response
	end
	def connect(usr_name, client)
		#add them to the user list
		@users.add_user(usr_name, client)
		#reply connected.
		return "CONNECTED"
	end
	def broadcast(message)
		#Loop through users and send the message to every socket.
		@users.list.each do |each|
			each.client.puts message
		end
		#notify sent.
		return "SENT"
	end
	def send(username, message)
		#Loop to find user.
			#send message to socket.
		if username
			return "SENT"
		else
			return "FAILED"
		end
	end
	def userlisting()
		result = @users.list_users()
		return "USERS #{result}"
	end
	def disconn(client)
		#remove user from list.
		@users.del_user(client)
		#respond disconnected.
		return "DISCONNECTED"
	end
end #server end
class UserList
	@list
	
	def initialize
		@list = []
	end
	def check_user(target)
		@list.each do |usr|
			return true if usr == target
		end
		false
	end
	def list_users()
		#build the list.
		all_users = ""
		@list.each do |each|
			all_users = all_users + each[1] + ", "
		end
		return all_users
	end
	def add_user(name, client)
		connection = [name, client]
		@list<<connection
	end
	def del_user(client)
		@list.each do |target|
			if target[1] = client
				@list.delete(target)
			end
		end
	end
end