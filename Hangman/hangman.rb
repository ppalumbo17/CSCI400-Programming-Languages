#Peter Palumbo
#Hangman
#September 6, 2016

require "io/console"
require "./words"
=begin
This is the common word game Hangman
=end

class Hangman
=begin
	initialize will create an instance of hangman
	it will also choose a word from the file "words.txt"
=end	
	def initialize(fileName = "words.txt")
		word_instance = Words.new(fileName)
		@my_word = word_instance.choose_word
		@letters_guessed = ""
		@guesses_left = 6
		@gameover = false
		
	end
=begin
	print_word prints THE WORD and then fills in the gaps
	of the actual word leaving a _ if that letter hasn't been guessed
=end
	def print_word
		puts "THE WORD"
		count = 0
		@is_winner = true
		@my_word.split("").each{|letter|
			if @letters_guessed.include? "#{letter}"
				print "#{letter}"
			else
				@is_winner = false
				print "_"
			end
			count += 1
			}
		if @is_winner
			@gameover = true
		end
		puts ""
	end
=begin
	bad_guesses keeps track of the number of guesses_left
	it then prints the letters you've guessed and number you have remaining
=end
	def bad_guesses
		if @guesses_left < 6
			print "Bad guesses (only #{@guesses_left} left!): "
			@letters_guessed.split("").each{|letter|
				if !@my_word.include? letter
					print letter
				end
			}
			puts ""
		end
	end

=begin 
	request_input will ask the user for a new letter to guess
=end
	def request_input
		puts ""
		print "Enter your next letter or '0' to guess the answer: "
	end

=begin
		get_user_input recieves the user input and determines whether it is correct
=end
	def get_user_input
		user_guess = STDIN.getch.downcase
		puts user_guess
		if user_guess != "0"
			@letters_guessed += user_guess
			if !@my_word.include? user_guess
				@guesses_left-=1
			end
			puts ""
			if @guesses_left==0
				@gameover = true
			end
		end
		return user_guess
	end

=begin 
	get_user_guess checks whether or not the guessed word is true
=end
	def get_user_guess
		puts "What's the word?"
		user_word =gets.chomp
		if @my_word.eql? user_word
			puts "That is correct, you win!"
		else
			puts "That is not correct, you lose!"
		end
	end

=begin
		gameover determines whether or not the game has come to an end
=end
	def gameover
		if @is_winner
			puts "Congratulations, you win!"
		else 
			puts "Sorry, too many bad guesses!"
		end
		puts ""
	end

=begin
	is_gameover is the getter for whether or not the game is over
=end
	def is_gameover
		return @gameover
	end

end

=begin
	start of non hangman class 
=end
while(true)
	if ARGV.length > 0
		game = Hangman.new(ARGV[0])
	else
		game = Hangman.new
	end
	while !game.is_gameover
		game.print_word
		if game.is_gameover
			game.gameover
			break
		else
			game.bad_guesses
			game.request_input
			if game.get_user_input=="0"
				game.get_user_guess
				break
			end
			if game.is_gameover
				game.gameover
			end
		end
	end
	puts "Enter 'q' tp quit or any other character for another game: "
	user_in = STDIN.getch
	puts user_in
	if user_in == "q" then break else puts "" end
end

