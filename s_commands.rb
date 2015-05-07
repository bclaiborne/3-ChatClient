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
				puts "Broadcast Request"
				response = broadcast(tokens)
			when "SEND"
				puts "Send Request"
				response = send(tokens)
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
	def send(tokens)
        target_user = tokens[1]
        #THIS IS DUCK TYPING
        #Isolate the message.
        tokens.shift(2).join(" ")
        #find user
        @user_list.each do |usr|
			#send message to target socket.
            if usr[:name] == target_user
                usr[:sock].puts tokens
                return "SENT"
            end
        end
        return "FAILED"
	end
	def userListing()
		#build the list.
		all_users = ""
        puts "Start listing.."
		@user_list.each {|usr|
            all_users = all_users + ", " + usr[:name] 
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

