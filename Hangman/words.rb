#Peter Palumbo
#Separate words class for hangman
#September 6, 2016

class Words
=begin
	initialize_words initializes the word array to store 
	words from a file 
=end
	def initialize(fileName)
		@wordlist = Array.new
		load_words(fileName)
	end

	def load_words(fileName)
		input = File.new(fileName, "r")
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
