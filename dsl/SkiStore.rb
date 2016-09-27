# Cody Watters
# Peter Palumbo
# CSCI400 

require 'singleton'

# TODO rename products to something else

class SkiStore

	attr_accessor :current_product, :products

	include Singleton

	def initialize
		@products = Hash.new
	end

	def add_product(text)
		@products[text] = Array.new	
	end
	
	def add_action(action)
		@products[@current_product] << action
	end

	# Main loop
	def start_store
		still_running = true

		while still_running

			option = main_menu

			case option
				when '1'
					puts ''
					load_rules
					puts ''
				when '2' 
					process_orders
				when '3'
					puts "bye"
					still_running = false
				else
					puts "invalid choice" #TODO make this error handle-a-ble
				end
		end
	end

	def main_menu
		puts "____.: Main Menu :.____"
		puts "1. Load Rules"
		puts "2. Process Orders"
		puts "3. End"

		return $stdin.gets.chomp.downcase
	end

	def load_rules 

		# First load the file itself and check if it is valid
		puts 'Enter filename containing rules: '
		filename = $stdin.gets.chomp

		# Chompt off the .txt if it's there, and then slap it right back
		unless filename.index(".txt").nil?
			filename = filename[0, filename.index(".txt")]
		end
		
		filename += '.txt'

		begin
			puts "loading #{filename} ..."
			load filename 
			puts ''
		rescue LoadError => ex
			puts "Invalid filename: #{ex}"
		end

		#TODO
		# here put another rescue for an improper file

		# testing / ease of grading - print out all the products
		puts "(testing) Products :::"
		@products.each do |key, values|
			print "#{key}: "
			values.each do |value|
				print "#{value}, "
			end
			puts ''
		end

	end


	# Loop for actually putting orders and such
	def process_orders

		puts ''
		still_processing = true

		while still_processing
			puts "Enter product type or 'D' (done) to end:"
			product_choice = gets.chomp

			# Break out 
			if product_choice == 'd' || product_choice == 'done'
				still_processing = false
			
			# Perform each action for the item
			else
				if(SkiStore.instance.products.keys.include? product_choice)
					@products.fetch(product_choice).each{|action| puts "---- #{action}"}
				else
					#TODO this throw error
					puts "TODO THIS NEEDS TO THROW AN ERROR I THINK"
					puts "Error: Product not defined"
				end

			end
		end
		puts ''
	end
end

def product(text)
	temp = text.chomp
	if !SkiStore.instance.products.keys.include? temp	#check if duplicate
		SkiStore.instance.add_product(temp)
	end
	SkiStore.instance.current_product = temp
end

def email (input)
	SkiStore.instance.add_action("email #{input}")
end

def notify (input)
	SkiStore.instance.add_action("notify #{input}")
end

def packing_slip (input)
	SkiStore.instance.add_action("packing slip to #{input}")
end

def pay (input)
	SkiStore.instance.add_action("pay #{input}")
end

def includes (input) # Can't name a function in ruby include
	SkiStore.instance.add_action("include #{input}")
end

# No arguments

def activate_membership
	SkiStore.instance.add_action("activate membership")
end

def warranty_card
	SkiStore.instance.add_action("warranty card")
end

# For fun

def notify_law_authorities
	SkiStore.instance.add_action("notify law authorities")
end

def call_number (input)
	SkiStore.instance.add_action("call #{input}")
end

def chase_out_of_store (input)
	SkiStore.instance.add_action("chase #{input} out of store")
end
