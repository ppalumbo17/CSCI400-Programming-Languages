#Peter Palumbo and Cody Watters
#NIM
#September 19, 2016

require 'test/unit'
require_relative "Nim"

class NimTester < Test::Unit::TestCase

	
	def test_a_move
		
		nim = Nim.new
		nim.instance_variable_set(:@comp_type, "smart_computer_player")

		nim.instance_variable_set(:@current_layout, [1,0,0,0] )
		nim.send(:smart_computer_player)
		assert_equal( nim.instance_variable_get(:@current_layout), [0,0,0,0] )

		nim.instance_variable_set(:@current_layout, [0,1,0,0] )
		nim.send(:smart_computer_player)
		assert_equal( nim.instance_variable_get(:@current_layout), [0,0,0,0] )

		nim.instance_variable_set(:@current_layout, [0,0,1,0] )
		nim.send(:smart_computer_player)
		assert_equal( nim.instance_variable_get(:@current_layout), [0,0,0,0] )

				nim.instance_variable_set(:@current_layout, [0,0,0,1] )
		nim.send(:smart_computer_player)
		assert_equal( nim.instance_variable_get(:@current_layout), [0,0,0,0] )
	end

end