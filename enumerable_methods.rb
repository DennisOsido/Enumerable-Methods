# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/CaseEquality, Metrics/MethodLength
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < size
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    selected_array = []
    my_each do |element|
      selected_array << element if yield(element)
    end
    selected_array
  end

  def my_all?(para = nil)
    result = true
    my_each do |element|
      if block_given?
        result = false unless yield(element)
      elsif para.nil?
        result = false unless element
      else
        result = false unless para === element
      end
    end
    result
  end

  def my_any?(para = nil)
    return my_any?(para) if block_given? && !para.nil?

    if block_given?
      to_a.my_each do |element|
        return true if yield element

        false
      end
    elsif para.is_a? Regexp
      to_a.my_each do |element|
        return true if element.to_s.match(para)
      end
    elsif para.is_a? Class
      to_a.my_each do |element|
        return true if element.is_a? para
      end
    elsif para
      to_a.my_each do |element|
        return true if element == para
      end
    elsif para.nil?
      to_a.my_each do |element|
        return true if element
      end
    end
    false
  end

  def my_none?(para = nil)
    return my_none?(para) if block_given? && !para.nil?

    if block_given?
      to_a.my_each do |element|
        return false if yield element

        false
      end
    elsif para.is_a? Regexp
      to_a.my_each do |element|
        return false if element.to_s.match(para)
      end
    elsif para.is_a? Class
      to_a.my_each do |element|
        return false if element.is_a? para
      end
    elsif para
      to_a.my_each do |element|
        return false if element == para
      end
    elsif para.nil?
      to_a.my_each do |element|
        return false if element
      end
    end
    true
  end

  def my_count(para = nil)
    count = 0
    if block_given?
      my_each do |element|
        count += 1 if yield(element)
      end
    elsif para
      my_each do |element|
        count += 1 if element == para
      end
    else
      count = size
    end
    count
  end

  def my_map(prc = nil)
    arr = []
    return to_enum(:my_map) unless prc or block_given?

    my_each do |elem|
      mapped = yield(elem) if block_given?
      arr.push(prc ? prc.call(elem) : mapped)
    end
    arr
  end

  def my_inject(para1 = nil, para2 = nil)
    array = is_a?(Array) ? self : to_a
    symbol = para1 if para1.is_a?(Symbol) or para1.is_a?(String)
    if para1.is_a?(Integer)
      accumulate = para1
      symbol = para2 if para2.is_a?(Symbol) or para2.is_a?(String)
    end
    if symbol
      array.my_each do |i|
        accumulate = accumulate ? accumulate.send(symbol, i) : i
      end
    elsif block_given?
      array.my_each do |i|
        accumulate = accumulate ? yield(accumulate, i) : i
      end
    end
    accumulate
  end

  def multiply_els(array)
    array.my_inject(:*)
  end
end

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/CaseEquality, Metrics/MethodLength
