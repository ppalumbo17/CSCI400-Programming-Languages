#Peter Palumbo
#Tests for hangman
#September 6,2016

require 'minitest/autorun'
require 'test/unit'
require './words'

class GameTest < Test::Unit::TestCase
	def test_words_read
		instance = Words.new("words.txt")
		assert_equal(4, instance.list_length)
		new_instance = Words.new("otherWords.txt")
		assert_equal(8, new_instance.list_length)
	end

	def test_words_randomized
		instance = Words.new("words.txt")
		apple_count = 0
		banana_count = 0
		grapefruit_count = 0
		kiwi_count = 0
		50.times{
			rand = instance.choose_word
			if rand == "apple" then apple_count += 1 end
			if rand == "banana" then banana_count += 1 end
			if rand == "grapefruit" then grapefruit_count += 1 end
			if rand == "kiwi" then kiwi_count += 1 end
		}
		assert(apple_count > 3)
		assert(banana_count > 3)
		assert(grapefruit_count > 3)
		assert(kiwi_count > 3)
	end
end

		