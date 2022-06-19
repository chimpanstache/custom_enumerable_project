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
    if !block_given?
      my_each { |item| return false if item == false || item == nil }
      return true
    end
    my_select(&block) == self
  end

  def my_none?(&block)
    self.my_select(&block).empty?
  end

  def my_count(param, &block)
    return self.my_select(&block).size if block_given?
    index = 0
    for element in self do
      index += 1
    end
    index
  end

  def my_map
    to_be_returned = []
    if block_given?
      for element in self do
        to_be_returned << yield(element)
      end
    end    
    to_be_returned
  end

  def my_inject(value = 0, &block)
    
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
      yield element
    end
  end
end
