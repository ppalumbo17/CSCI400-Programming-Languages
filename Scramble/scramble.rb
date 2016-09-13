#Peter Palumbo
#Scramble Project
#Spetember 9, 2016

require './words'

class Words
	def []
		fetch =@wordlist[@current]
		@current += 1
		return fetch
	end

	def get_current()
		return @current
	end
end

class Scramble
	def initialize()
		@words = Words.new
	end

	def get_word()
		word = @words[]
	end

	def end_game()
		return @words.get_current == @words.list_length
	end
end

game = Scramble.new
while true
	current_word=game.get_word
	puts "Scrambled word: #{current_word.split("").shuffle.join}"
	puts ""
	puts "What's the word?"
	guess = gets.chomp
	if guess == current_word
		puts "That is correct!"
	else
		puts "Sorry, that's not correct."
	end
	puts ""
	if game.end_game
		puts "You have reached the end of the word list!"
		break
	else
		puts "Continue? (Y/N)"
		input = gets.chomp
		if input == "N" || input == "n"
			break
		end
	end
end