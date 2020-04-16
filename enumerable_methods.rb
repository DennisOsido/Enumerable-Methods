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

	def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
		i = 0
		index = 0
    while i < self.size do
      yield(self[i], index)
      i += 1
    end
    self
  end


end
# rubocop:enable Style/CaseEquality

puts
puts "my_each method"

nums = [2, 4, 6, 8]
nums.my_each do |n|
	n /= 2
  puts "#{nums[n - 1]} divided by 2 is: #{n}"
end

puts

puts "my_each_with_index method"
[2, 4, 6, 8].my_each_with_index do |n, index|
	puts "Index: #{index} | Value: #{n}"
end

puts
