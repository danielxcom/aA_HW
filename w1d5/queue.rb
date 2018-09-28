class Queue

  def initialize
    @fifo = []
  end

  def enqueue(el)
    @fifo.unshift(el)
    el
  end

  def dequeue
    # @fifo.pop incorrect because first out.
    @fifo.shift
  end

  def peek
    @fifo.first
  end
end
