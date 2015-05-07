class Server
	attr_accessor :socket, :users
	
    #Start the server.
	def initialize
		@socket = TCPServer.new 2000 # Server bound to port 2000
		@user_list = []
	end
    #Switch on command. Disconnect command is dealt with in the server loop.
	def parse(msg, sock)
		#Pull the name out
        if msg[1] !=nil
            screen_name = msg[1].strip
        end
        #Pull the command
		command = msg[0].strip
		case command
			when "CONNECT"
				puts "Connection Request"
                response = connect(screen_name, sock)
			when "BROADCAST"
				puts "Broadcast Request"
				response = broadcast(msg)
			when "SEND"
				puts "Send Request"
				response = send(msg)
			when "USERLIST"
				puts "Userlist Request"
				response = userListing()
			else
			response = "I don't know what #{msg[0]} means." 
		end
		return response
	end
    #Adds a user and their socket to the UserList on valid connection.
	def connect(usr_name, client)
        if usr_name
            user = {name: usr_name, sock: client}
            #Add the user and its connection to the userList
            @user_list.push(user)
            return "CONNECTED"
        else
            return "FAILED"
        end
	end
    #Broadcasts the message to all users.
	def broadcast(message)
        #Remove the leading command and join with spaces.
        message.shift
        #Join fails if it isn't an array with more than one value.
        if message.length > 1
            message.join(" ")
        end

        #Loop through users and send the message to every socket.
		@user_list.each do |each|
			each[:sock].puts message
		end
		#Notify sent.
		return "SENT"
	end
    #Private Message Send to only one user.
	def send(tokens)
        target_user = tokens[1]
        #Isolate the message.
        tokens.shift(2).join(" ") #THIS IS DUCK TYPING an array to a string.

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
    #Returns a comma seperated list of connected users.
	def userListing()
		#build the list.
		all_users = ""
        puts "Start listing.."
		@user_list.each {|usr|
            all_users = all_users + usr[:name] + ", " 
		}
		return "USERS:#{all_users}"
	end
    #Kills the connection
	def disconn(client)
		#Find the user.
		@user_list.each do |usr|
            if usr[:sock] == client
                #Delete the user from the list.
                @user_list.slice!(@user_list.index(usr))
                puts @user_list
                return "DISCONNECTED"
            end
        end
        return "User not found"
	end
end

