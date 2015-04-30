
def connect(my_name)
	soc.send "CONNECT #{my_name}"
end
def broadcast(message)
	soc.send "BROADCAST #{message}"
end
def send(username, message)
	soc.send "SEND #{username} #{message}"
end
def users(user_list)
	soc.send "USERS #{user_list}"
end
def dconn
	soc.send "DISCONNECT"
end