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

  def my_all?(p = nil)
    result = true
    if block_given?
      my_each do |element| 
        result = false unless yield(element)
      end
    else
      my_each do |element| 
        result = false unless element
      end
    end
    result
  end

  def my_any?(p = nil)
    return my_any?(p) if block_given? && !p.nil?
    if block_given?
      to_a.my_each do |element|
        if yield element
          return true
        end  
      false
      end
    elsif p
      to_a.my_each do |element|
        if element == p
          return true
        end  
      end  
    elsif p.nil?
      to_a.my_each do |element|  
        if element
          return true
        end  
      end
    end
    false
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

puts "my_all? method"
nums = [13, 7, 24, 39]
print nums
puts
print "All are odd? = "
print nums.my_all? { |n| n.odd? }
puts
puts

puts "my_any? method"
nums = [13, 7, 25, 38]
print nums
puts
print "Is any even? = "
print nums.my_any? { |n| n.even? }

puts
