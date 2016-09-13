gem "minitest"
require 'minitest/autorun'
# for prior versions of Ruby (e.g., 1.9.3), use test/unit
#require 'test/unit'
require_relative "RegExpFun"
include RegExpFun

=begin
Not a real unit test, just a chance to experiment with some reg exp. 
Try to use match data for the first two.
=end
str = "ruby is cool" 
print "What language is cool? " 
# so get_language looks for the thing that is cool
# do NOT just hard code ruby
puts RegExpFun.get_language(str)
str = "Ruby on Rails is cool" 
print "What language is cool? " 
puts RegExpFun.get_language(str)
print "What do you think of the language? "
# the adjective is the last word in the sentence
puts RegExpFun.get_adjective(str)
str = "cost for 3.5 feet is $23.50"
print "How much does that cost? "
# cost of course starts with a $ and then includes dollars.cents
puts RegExpFun.get_price(str)

=begin
This is the real unit test
=end
class RegExpFunTester < Minitest::Test
# Test for complex numbers, including for example -3+4i, +5-6i, +7i, 8i, -12i
  def test_complex
    # simple i, 1 or more digits
    assert_equal(0, RegExpFun.is_complex("4i"))
    assert_equal(0, RegExpFun.is_complex("43i"))
    # simple i, 1 or more digits with sign  
    assert_equal(0, RegExpFun.is_complex("-46i"))
    assert_equal(0, RegExpFun.is_complex("+46i"))
    # simple real +/- imaginary
    assert_equal(0, RegExpFun.is_complex("35+46i"))
    assert_equal(0, RegExpFun.is_complex("3-46i"))
    # signed real and signed imaginary
    assert_equal(0, RegExpFun.is_complex("-35+46i"))
    assert_equal(0, RegExpFun.is_complex("+3-46i"))
    # a couple non-complex
    assert_equal(nil, RegExpFun.is_complex("abi"))
    assert_equal(nil, RegExpFun.is_complex("65"))    
  end
end