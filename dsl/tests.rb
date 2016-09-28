require 'test/unit'
require './SkiStore'

class SkiStoreTest < Test::Unit::TestCase


def test_bad_rules
	
	assert_raise(ArgumentError){SkiStore.instance.load_rules("badRules.txt")}
end

def test_rules
	SkiStore.instance.load_rules("goodRules.txt")
	assert(SkiStore.instance.products.include?("ski_video"))
	assert(SkiStore.instance.products.include?("ski_boots"))
	assert(SkiStore.instance.products.include?("membership"))
	assert(SkiStore.instance.products.include?("ski_helmet"))
	assert(SkiStore.instance.products.include?("snow_bike"))
	assert(SkiStore.instance.products.include?("person_tries_to_rob_the_store"))
	
	action = SkiStore.instance.products["ski_video"]
	assert(action.include?("packing slip to shipping"))
	assert(action.include?("pay comission"))
	assert(action.include?("include free first aid video"))

	assert(SkiStore.instance.products["membership"].include?("activate membership"))
	assert(SkiStore.instance.products["ski_boots"].include?("include boot fitting discount certificate"))
	assert(SkiStore.instance.products["person_tries_to_rob_the_store"].include?("call 9-11"))
	assert(SkiStore.instance.products["person_tries_to_rob_the_store"].include?("notify law authorities"))
	assert(SkiStore.instance.products["person_tries_to_rob_the_store"].include?("chase robber out of store"))
end


end
