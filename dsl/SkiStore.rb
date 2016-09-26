require 'singleton'

class SkiStore

	include Singleton

	def load_rules
		puts "load the rules TODO"
	end

	def main_menu
		puts "____.: Main Menu :.____"
		puts "1. Load Rules"
		puts "2. Process Orders"
		puts "3. End"

		return $stdin.gets.chomp.downcase
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

	def load_rules
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
		rescue LoadError => ex
			puts "Invalid filename: #{ex}"
		end
	end


	# Loop for actually putting orders and such
	def process_orders

		puts ''
		still_processing = true

		while still_processing
			puts "Enter product type or 'D' (done) to end:"
			option = gets.chomp.downcase
			if option == 'd' || option == 'done'
				still_processing = false
			else
				puts "todo #{option}"
			end
		end
		puts ''
	end

	
end