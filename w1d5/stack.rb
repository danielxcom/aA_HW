# framework:

# class Stack
#   def initialize
#     # create ivar to store stack here!
#   end
#
#   def push(el)
#     # adds an element to the stack
#   end
#
#   def pop
#     # removes one element from the stack
#   end
#
#   def peek
#     # returns, but doesn't remove, the top element in the stack
#   end
# end

class Stack
  attr_accessor :lifo

  def initialize
    @lifo = []
  end

  # def push(el)
  #   self.lifo.push(el)
  #   return el
  # end

  def push(el)
    @lifo << el
    el
  end

  def pop
    @lifo.pop
  end

  def peek
    @lifo.last
  end
end
