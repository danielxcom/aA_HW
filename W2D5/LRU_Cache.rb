class LRUCache
  attr_accessor :size

  def initialize(size)
    @data = []
    @size = size
  end

  def count
    @data.count
  end

  def add(param)
    if @data.include?(param)
      remove(param)
      update(param)
    elsif @data.count >= @size
      shifted
      update(param)
    else
      update(param)
    end
  end

  def peek
    puts @data
  end

  private
  def remove(param)
    @data.delete(param)
  end
  def update(param)
    @data << param
  end
  def shifted
    @data.shift
  end

end


# Attempt with Hash.
# class LRUCache
#     def initialize(max_size)
#       @max_size = max_size
#       @data = Hash.new
#     end
#
#     def count
#       @data.keys.count
#     end
#
#     def add(el)
#       @data.delete(el) if @data.has_key?(el)
#       @data[el] = true
#
#     end
#
#     def show
#       # shows the items in the cache, with the LRU item first
#       p @data
#
#     end
#
#     # private
#     def delete(el)
#       @data.delete(el)
#     end
#
#   end
