# Test
require "test/unit"
require 'socket'
require_relative "s_commands"
require_relative "c_commands"

class TestServer < Test::Unit::TestCase
	def test_Server
		test_S = Server.new()
        # Test server class.
		assert_kind_of(Server, test_S)

        soc = TCPSocket.new 'localhost', 2000
		# Parse Function
        # Also tests Connect function
		assert_equal("CONNECTED", test_S.parse(["CONNECT", "me"], soc))
		assert_equal("CONNECTED", test_S.parse(["CONNECT", "you"], soc))
        # Also tests Broadcast function
        assert_equal("SENT", test_S.parse(["BROADCAST","junk"], soc))
        # Also tests Send function
        assert_equal("SENT", test_S.parse(["SEND","you","junk"], soc))
        # Also tests userlist function
		assert_equal("USERS:me, you, ", test_S.parse(["USERLIST"], soc))
        # Test general failure.
        assert_equal("I don't know what DORF means.", test_S.parse(["DORF","you","junk"], soc))
#		assert_kind_of(Integer, test_S.set_unit(5))

	end
end
class TestClient < Test::Unit::TestCase
    def test_Client
        # Cannot test the Client class or send/get functions because they are non terminating threads.
        # Instantiating a server and Client will just start threads.

		#test_S = Server.new()
        #soc = TCPSocket.new 'localhost', 2000
        #test_C = Client.new(soc)
        
        # Test Client class.
		#assert_kind_of(Client, test_C)
        
        # Not much to test on the client side. Just two threads that take/post stdio.
#        assert_kind_of(Thread, test_C.outgoing)
#        assert_kind_of(Thread, test_C.incoming)
        
    end
end