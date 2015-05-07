class Client
    #Remember the two threads and the server we are talking to.
    @outgoing
    @incoming
    @server
    
    def initialize(server)
        @server = server
        #Incoming thread function.
        get()
        #Outgoing thread function.
        send()
        @outgoing.join
        @incoming.join
    end
    def send
        #Create an outgoing Thread to send messages
        @outgoing = Thread.new do
            loop do
                #Write stuff
                message = $stdin.gets.chomp
                #send the stuff
                @server.puts(message)
            end
        end
    end
    def get
        #Create an incoming thread to receive messages.
        @incoming = Thread.new do
            loop do
                #listen for stuff
                message = @server.gets.chomp
                #display them in console.
                puts message
            end
        end
    end
end
