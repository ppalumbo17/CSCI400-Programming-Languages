#Peter Palumbo and Cody Watters
#NIM
#September 19, 2016

require_relative "Nim"

class NimTester
	def initialize
		@nim = Nim.new
		@nim.set_for_testing('a')
	end
	
	def play
		done_playing = false
		while !done_playing

			# Loop through each instance method
			Nim.instance_methods.each  do |fn|

				# Perform a turn
				if /computer_player/ =~ fn
					if  @nim.game_complete == false
						@nim.instance_variable_set(:@comp_type, fn) 
						@nim.send(fn)
					else
						done_playing = true
					end
				end
			end # fn

		end
		@nim.the_winner_is
	end

	def play_automatically
		(0..100).each do |i|
			play
		end
	end

end

nimTester = NimTester.new
nimTester.play_automatically