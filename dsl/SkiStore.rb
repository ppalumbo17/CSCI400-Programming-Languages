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

		puts "loading #{filename} ..."

		begin
			load filename 
			puts ''
		rescue LoadError => ex
			puts "Invalid filename: #{ex}"
		end

		#TODO
		# here put another rescure for an improper file

		# testing
		puts "products"
		puts @products

	end


	# Loop for actually putting orders and such
	def process_orders

		puts ''
		still_processing = true

		# testing
		puts "products"
		puts @products

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

	# TESTING DELETEME
	puts 'pause product in product'
	puts @products
	ind = gets
end


def email (input)
	SkiStore.instance.add_action("email #{input}")
end