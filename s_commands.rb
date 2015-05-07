class Server
	attr_accessor :socket, :users
	
	def initialize
		@socket = TCPServer.new 2000 # Server bound to port 2000
		@user_list = []
	end
	def parse(msg)
		#Pull the message out
		#message = msg
		tokens = msg.strip.split(" ")
		command = tokens[0].strip
		case command
			when "CONNECT"
				puts "connect request"
				response = "You are already connected."
			when "BROADCAST"
				puts "broadcast request"
                #get rid of the command.
				response = broadcast(tokens)
			when "SEND"
				puts "send request"
				response = send(tokens[1], tokens[2])
			when "USERLIST"
				puts "userlist request"
				response = userListing()
			else
			response = "I don't know what #{tokens[0]} means." 
		end
        puts response
		return response
	end
	def connect(usr_name, client)
        user = {name: usr_name, sock: client}
        #Add the user and its connection to the userList
        puts user
        @user_list.push(user)
	end
	def broadcast(message)
        #Remove the leading command and join with spaces.
        message.shift.join(" ")

        #Loop through users and send the message to every socket.
		@user_list.each do |each|
			each[:sock].puts message
		end
		#notify sent.
		return "SENT"
	end
	def send(username, message)
		#Loop to find user.
        @user_list.each do |each|
            username = each.name
            socket = each.socket
			#send message to socket.
            if username
                socket.puts message
                return "SENT"
            else
                return "FAILED"
            end
        end
	end
	def userListing()
		#build the list.
		all_users = ""
        puts "Start listing.."
		@user_list.each {|sock|
            all_users = all_users + ", " + sock[:name] 
		}
		return "USERS:#{all_users}"
	end
	def disconn(client)
		#remove user from list.
		@user_list.del_user(client)
		#respond disconnected.
		return "DISCONNECTED"
	end
end

