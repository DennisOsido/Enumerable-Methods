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
      yield(self[i], i)
      i += 1
    end
    self
  end

	def my_select
    return to_enum(:my_select) unless block_given?
    selected_array = []
    my_each do |element|
      if yield(element)
        selected_array << element
      end
    end
    selected_array
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

puts "my_select method"
nums_array = [5, -4, 0, 9]
print "Sample Array of Numbers: #{nums_array}"
puts
nums_array.my_select do |x|
  if x.positive?
    puts "#{x} is positive"
  end
end

puts
