require 'byebug'

def sum_to(n)
  return nil if n < 0
  return 1 if n == 1

  sum_to(n - 1) + n
end

def add_numbers(nums_array)
  return 0 if nums_array.empty?

  nums_array.shift + add_numbers(nums_array)
end

def gamma_function(num)
  return nil if num < 1
  return 1 if num == 1

  gamma_function(num - 1) * (num -1)
end

def ice_cream_shop(flavors, favorite)
  return false if flavors.empty?

  if flavors.shift == favorite
    debugger
    return true
  else
    ice_cream_shop(flavors, favorite)
  end
end


def reverse(string)
  return "" if string.empty?

  reverse(string.slice(1, string.length)) + string[0]
end
