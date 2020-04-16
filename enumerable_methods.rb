# rubocop:disable Style/CaseEquality
module Enumerable
	
	def my_each
		return to_enum(:my_each) unless block_given?
		i = 0
		while i < self.size do 
			yield self[i]
			i += 1
		end
		self  
	end

end    
# rubocop:enable Style/CaseEquality

[3, 6, 9, 12].my_each do |n| 
	n /= 3
  puts "Current number divided by 3 is: #{n}"
end
