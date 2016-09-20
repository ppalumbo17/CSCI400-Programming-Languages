#Peter Palumbo and Cody Watters
#Email Log
#September 13, 2016

module EmailLog
	def getMessages
		lines = File.open("mail.log", 'r')	
		lines.each_line do |line|

			if line[/size/]			
				id = line[/\b([A-Z]|[0-9]){11}:/][0..10]	
				size = line[/size=[0-9]+/][/[0-9]+/]
				date_info = line[/(.){3} [0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}/]
				check_hash(id)
				$info[id].set_date(date_info)		
				$info[id].set_size(size)			
			end
			
			if line[/from=</] && line[/postfix\/qmgr/]		 
				id = line[/\b([A-Z]|[0-9]){11}:/][0..10]	
				from = line[/from=<.*>/]
				start = (/</ =~ from) + 1 		
				finish = from.length-2			
				from = from[start..finish]		
				check_hash(id)
				$info[id].email_from(from)		
			end

			if line[/\bto=<\S*>/]
				id = line[/\b([A-Z]|[0-9]){11}:/][0..10]	
				to = line[/\bto=<\S*>/]
				start = (/</ =~ to) + 1 		
				finish = to.length-2			
				to = to[start..finish]			
				check_hash(id)
				$info[id].email_to(to)			
			end
		end
	end

	def check_hash(id)			 
		if !$info.has_key?(id)
			$info[id] = Email.new
		end
	end
end

class Email
	def initialize()					
		@to = Array.new
		@date
		@size
		@from
	end

	def email_to(to)					
		@to.push(to)
	end

	def email_from(from)				
		@from = from
	end

	def set_size(size)					
		@size = size
	end

	def set_date(date)		
		@date = date
	end

	def print_date		
		return @date
	end

	def print_size				
		return @size
	end

	def print_from				
		return @from
	end

	def print_to()			
		recipients = ""
		@to.each {|recipient| recipients += "#{recipient} "}
		return recipients
	end

	def to_string()			
		return "Date: #{print_date} ID: #{$info.key(self)} Size:#{print_size} \nFrom: #{print_from}\nTo: #{print_to}\n\n"
	end
end

if __FILE__ == $0 			
	include EmailLog
	$info = Hash.new		
	EmailLog.getMessages
	puts "Total Number of Emails: #{$info.keys.length}\n\n"		
	$info.keys.each do |key|
		puts $info[key].to_string			
	end
	puts "Total Number of Emails: #{$info.keys.length}\n\n"		
end