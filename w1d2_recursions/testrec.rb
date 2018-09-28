def range(min, max)
  return [] if max <= min
  print min
  range(min, max - 1) << max - 1
end

def sum_rec(nums)
  return 0 if nums.length == 1
  sum_rec(nums[0..-2]) + nums[-1]
end

def exp1(base, power)
  return 1 if power < 2
  base * exp1(base, power - 1)
end

def exp2(base, power)
  return 1 if power == 0

  recursed = exp2(base, power / 2)
  if power.even?
    recursed * recursed
  else
    base * (recursed * recursed)
  end
end

class Array
  def deep_dup
    result = []

    self.each do |el|
      if el.is_a?(Array)
        result << el.deep_dup
      else
        result << el
      end
    end

    result
  end
end


def best_fibs(n)

  return [0, 1] if n < 2
  result_arr = []
  prev_fibs = best_fibs(n -1)

  arr_slot = prev_fibs[-1] + prev_fibs[-2]
  result_arr = prev_fibs << arr_slot
  result_arr
end


class Array
  def quicksort
    return [] if self.length < 2
    pivot = length / 2

    left = select{|el| el < pivot}
    right = self[pivot..-1].select {|el| el >=pivot}

    leftQ=left.quicksort
    rightQ = right.quicksort
    leftQ + [pivot] + rightQ
  end
end


class Array
  def my_each_rec(&prc)
    prc ||= Proc.new {|el1, el2| el1 <=> el2}
    i = 0
    # while i < self.length
    #   prc.call(self[i])
    # # prc.call(self.my_each_rec(&prc))
    # end
    self
  end
end


class Array
  def my_merge_sort
    return self if self.empty?

    pivot = length / 2
    left = self[0...pivot]
    right = self[pivot+1..-1]

    left_m = left.quicksort
    right_m = right.quicksort

    merge_helper(left_m, right_m)
  end

  def merge_helper(left, right)
    result = []
    until left.empty? || right.empty?
      case left[0] <=> right[0]
      when -1
        result << left.shift
      when 0
        result << left.shift
      when 1
        result << right.shift
      end
    end
    result + left + right
  end
end
