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

  def my_none?(p = nil)
    return my_none?(p) if block_given? && !p.nil?
    if block_given?
      to_a.my_each do |element|
        if yield element
          return false
        end  
      false
      end
    elsif p
      to_a.my_each do |element|
        if element == p
          return false
        end  
      end  
    elsif p.nil?
      to_a.my_each do |element|  
        if element
          return false
        end  
      end
    end
    true
  end

  def my_count(p = nil)
    count = 0
    if block_given?
      my_each do |element|
        if yield(element)
          count += 1 
        end  
      end
    elsif p
      my_each do |element|
        if element == p
          count += 1 
        end  
      end
    else
      count = size
    end
    count
  end

  def my_map(prc = nil)
    arr = []
    if prc
      my_each do |elem|
        arr << prc.call(elem)
      end  
    else
      my_each do |elem| 
        arr << yield(elem)
      end  
    end
    arr
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
puts

puts "my_none? method"
nums = [13, 7, 25, 39]
print nums
puts
print "None are even? = "
print nums.my_none? { |n| n.even? }
puts
puts

puts "my_count method"
nums = [13, 8, 24, 39]
print nums
puts
print "How many are even? = "
print nums.my_count { |n| n.even? }
puts
puts

puts "my_map method"
nums = [2, 4, 6, 8]
print nums
puts
nums.my_map do |n|
  n * 2
  puts "#{n} multiplied by 2 is: #{n}"
end
puts
puts
