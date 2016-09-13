#Peter Palumbo
#Separate words class for Scramble
#September 9, 2016

class Words
=begin
	initialize_words initializes the word array to store 
	words from a file 
=end
	def initialize
		@wordlist = Array.new
		@current = 0
		load_words
	end

	def load_words
		input = File.new("words.txt", "r")
		while(line = input.gets)
			line.split(' ').each {|word| @wordlist.push(word)}
		end
		input.close
	end

	def choose_word
		my_word = @wordlist[rand(@wordlist.length)]
	end

	def list_length
		return @wordlist.length
	end

end
