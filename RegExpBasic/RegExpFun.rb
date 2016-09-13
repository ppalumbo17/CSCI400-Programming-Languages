#Peter Palumbo
#Reg Exp Basic
#September 12, 2016

module RegExpFun
	def get_language(str)
		/[Rr]uby/ =~ str
	end
	def get_adjective(str)
		/cool/ =~ str
	end
	def get_price(str)
		/\$[0-9]*\.[0-9]{2}/ =~ str
	end

end

