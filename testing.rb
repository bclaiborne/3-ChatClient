# Test
require_relative "s_commands"
require "test/unit"

class TestServer < Test::Unit::TestCase
	def test_Server
		test_S = Server.new()
		# Parse Function
		assert_equal("CONNECTED", test_S.parse("CONNECT me"))
		assert_equal("CONNECTED", test_S.parse(" CONNECT you"))
		assert_equal("I don't know what CO means.", test_S.parse(" CO you"))
		assert_equal("SENT", test_S.parse("BROADCAST junk"))
		assert_equal("SENT", test_S.parse("SEND me junk"))
		assert_equal("USERS", test_S.parse("USERLIST"))
		assert_equal("DISCONNECTED", test_S.parse("DISCONNECT"))
		assert_kind_of(Integer, test_S.set_unit(5))

		assert(test_S.select_territory.is_a?(Territory))
		assert_match( /(.*)/ , test_S.set_name())
	end
end