#Peter Palumbo and Cody Watters
#Email Log Test
#September 13, 2016

require 'test/unit'
require './EmailLogMain'
include EmailLog

class EmailLogTest < Test::Unit::TestCase
	def test_email_count
		$info = Hash.new		
		EmailLog.getMessages
		assert_equal(61, $info.keys.length)		
	end

	def test_multi_to		
		$info = Hash.new		
		EmailLog.getMessages
		assert_equal("echopper@mines.edu mheck@mines.edu frodobaggins@mines.edu ", $info["1915B1B2004"].print_to)
	end

	def test_info			
		$info = Hash.new		
		EmailLog.getMessages
		assert_equal("mickeymouse@mymail.mines.edu ", $info["855911BA094"].print_to)
		assert_equal("1569", $info["9E59D1BA094"].print_size)
		assert_equal("Dec 12 22:29:01", $info["D6B513AA7DF"].print_date)
		assert_equal("www-data@toilers.Mines.EDU", $info["855911BA094"].print_from)
	end
end