class Map
  def initialize
    @inner_arr = []
  end

  def set(k, v)
    pair_idx = inner_arr.index { |pair| pair[0] == k }
    if pair_idx
      inner_arr[pair_idx][1] = v
    else
      inner_arr.push([k, v])
    end
    v
  end

  def get(k)
    inner_arr.each { |pair| pair[0] == k }
  end

  def delete(k)
    v = get(k)
    inner_arr.reject! {|pair| pair[0] == k }
    v
  end

  def show
    d_dup(inner_arr)
  end

  private

  attr_reader :inner_arr

  def d_dup(arr)
    arr.map { |el| el.is_a?(Array) ? d_dup(el) : el }
  end
end
