#Peter Palumbo and Cody Watters
#NIM
#September 19, 2016

# Used reflection in the setup_game function and looped through each function with
# the  name 'computer_player' in the name

class Nim

	# This will change as the game progresses
	@@current_layout
	@@layout_a = [1,3,5,7]
	@@layout_b = [4,3,7]

	def initialize
		@continue = true
	end

	def set_for_testing(layout)
		if (layout == 'a') 
			@current_layout = @@layout_a
		else
			@current_layout = @@layout_b
		end
		
	end

	def setup_game
		#@@layout_a = [1,3,5,7]
		#@@layout_b = [4,3,7]

		# Pick a board layout

		puts "Possible board configurations:"
		puts "0: #{@@layout_a}"
		puts "1: #{@@layout_b}"

		choice = gets.chomp.to_i
		puts ''

		case choice
			when 0
				puts "You've selected #{@@layout_a}"
				@current_layout = @@layout_a
			when 1
				puts "You've selected #{@@layout_b}"
				@current_layout = @@layout_b
			else puts "Error: that is not a valid board configuration"
		end

		# Pick the computer player (reflection)

		option = 0
		
		puts "Select the computer player:"

		computer_player_options = Array.new

		self.methods.each do |fn|
			if /computer_player/ =~ fn
				computer_player_options.push(fn)
				puts "#{option} : #{fn}"
				option += 1
			end
		end

		choice = gets.chomp.to_i
		puts ''

		# Default computer player
		@comp_type = computer_player_options[0]

		case choice
			when 0
				puts "You've selected #{computer_player_options[choice]}"
				@comp_type = computer_player_options[choice]
			when 1
				puts "You've selected #{@@layout_b}"
				@comp_type = computer_player_options[choice]
			else puts "Error: that is not a valid computer choice. Default dumb_computer_player"
		end

		puts "You're playing #{@comp_type}"

		play_game
	end

	def play_game
		while game_complete == false
			player_turn
      		send(@comp_type)
  		end
  		the_winner_is
	end

	def the_winner_is
		puts "the winner is: #{@winner}"
	end

	# Do not change the order of dumb / smart
	def dumb_computer_player
		if !game_complete
		random_try = false

			# Tries randomly and checks if it is a valid input
			while !random_try
				random_row = rand(0..@current_layout.length-1)
				random_sticks = rand(0..@current_layout[random_row])
				random_try = check_move(@comp_type, random_row, random_sticks)
    		end
		end
	end

	def smart_computer_player
		unless game_complete
	  		row, sticks = -1, -1
	  		
	  		# Copy the layout to a new array
	  		tryArray = Array.new(@current_layout)
	  		tryArray.each_with_index do |layout_row, layout_row_index|
	  			
	  			# Make a new try for the layout
	  			tryArray = Array.new(@current_layout)
	  			valid_option = false
	  			
	  			# If the row has sticks
	  			if layout_row > 0

	  				# Loop through each stick
			  		(0..(layout_row - 1)).each do |i|

			  			# Set the array to indexed values
			  			tryArray[layout_row_index] = i

			  			# xor (algorithm online)
			  			if xor(tryArray) == 0
			  				valid_option = true
			  				break
			  			end
			  		end
			  	end

			  	# If we get a match
	  			if valid_option

	  				# Return the row
	  				row = layout_row_index

	  				# Return the difference in number of sticks
	  				sticks = @current_layout[layout_row_index] - tryArray[layout_row_index]
	  				break
	  			end
	  		end #mainloop

	    	check_move(@comp_type, row, sticks)
		end #if
	end

	def xor(array)
		result = 0
  		array.each do |arrayItem|
  			result = result ^ arrayItem
  		end
  		return result
	end

	def player_turn
	  	move = false
	  	while move == false
	  		print_out_game_board
		    # get the user selections
		    valid_input = false
		    puts "Enter the row (1-#{@current_layout.length}): "
		    row_choice = gets.chomp.to_i - 1

		    # Check row input before validation
		    if row_choice < 0 || row_choice > @current_layout.length - 1 
		    	puts ''
		    	puts "Error: invalid row"
		    elsif @current_layout[row_choice] == 0
		    	puts ''
		    	puts "Error: please select a row that contains sticks"
		    	puts ''
		    else
		    	puts "Enter the number of sticks (1-#{@current_layout[row_choice]}): "
		    	stick_choice = gets.chomp.to_i    

		    	# Check stick choice before validation
		    	if stick_choice < 1 || stick_choice > @current_layout[row_choice]
		    		puts ''
		    		puts "Error: invalid stick choice"
		    	else
		    		move = true
		    		perform_move(row_choice, stick_choice)
		    		
		    		# Check to see if we just won
		    		if game_complete
        				@winner = 'human'
     				end
		    	end
		    end

	  	end
	end

	def print_out_game_board
		row_number = 1
		@current_layout.each do |row|
			print "#{row_number}: "
			(1..row).each do |i|
				print ' X'
			end
			puts ''
			row_number += 1
		end
	end

	def check_move (computer_type, row_choice, stick_choice)

		# Test that the row and stick are within a proper range
        if row_choice >= 0 && row_choice <= @current_layout.length - 1 && stick_choice > 0 && stick_choice <= @current_layout[row_choice]
          	valid_move = true
  		end

  		if valid_move
  			perform_move(row_choice, stick_choice)

			if game_complete
        		@winner = computer_type 
     		end

        	puts "#{@comp_type} took #{stick_choice} stick#{stick_choice > 1 ? 's' : ''} from row #{row_choice + 1}" #display move made by computer
     		
  		end

  		return valid_move
	end

	def perform_move (row_choice, stick_choice)
		@current_layout[row_choice] -= stick_choice		
	end

	def game_complete
		if @current_layout.inject{|sum,x| sum + x} == 0
			return true
		end
		return false
	end

end

if __FILE__ == $0
	nim = Nim.new
	nim.setup_game
end