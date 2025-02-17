module Enumerable
  # Your code goes here
  def my_each_with_index
    return self if !block_given?
    index = 0
    for element in self do
      yield element, index
      index += 1
    end
  end

  def my_select(&block)
    return Enumerator.new {} if !block_given?

    to_be_returned = []
    my_each { |element| to_be_returned << element if yield(element) == true }
    to_be_returned
  end

  def my_all?(&block)
    return my_select(&block) == self if block_given?

    my_each { |item| return false if item == false || item == nil }
    true
  end

  def my_any?(&block)
    return my_count(&block) > 0 if block_given?

    my_each { |item| return true if item == true }
    false
  end

  def my_none?(&block)
    return my_select(&block).empty? if block_given?

    my_each { |item| return false if item == true }
    true
  end

  def my_count(param = nil, &block)
    return self.my_select {|item| item == param }.size if param != nil
    return self.my_select(&block).size if block_given?
    my_each.size
  end

  def my_map(&block)
    return Enumerator.new {} if !block_given?
    to_be_returned = []
    my_each { |element| to_be_returned << yield(element) }
    to_be_returned
  end

  def my_inject(*arg)
    memo = 0
    memo = arg[0] if arg[0].is_a?(Integer)

    if arg[0].is_a?(Symbol)
      self.my_each {|item| memo = memo.send(arg[0], item) }
      return memo  
    elsif arg[1].is_a?(Symbol)
      self.my_each {|item| memo = memo.send(arg[1], item) }
      return memo  
    elsif block_given?
      self.my_each {|item| memo = yield(memo, item) }
      return memo
    end
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return self if !block_given?
    for element in self do
      yield(element)
    end
  end
end
