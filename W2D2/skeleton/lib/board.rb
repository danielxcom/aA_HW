class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) {[]}
    @name1 = name1
    @name2 = name2
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    fourStone = [:stone, :stone, :stone, :stone]

    (0...@cups.length).each do |idx|
      fourStone.each do |st|
        @cups[idx] << st unless idx == 6 || idx == 13
      end
    end

  end

  def valid_move?(start_pos)
    begin
      if start_pos > 12 || start_pos < 0
        raise InvalidStartingCup
      end
    end

    begin
      if @cups[start_pos].empty?
        raise StartCupEmpty
      end
    end
  end

  def make_move(start_pos, current_player_name)
    curr_pos = start_pos
    p1_storage = 6
    p2_storage = 13

    until @cups[start_pos].empty?
      curr_pos += 1
      if curr_pos > 13
        curr_pos = 0
      end

      # if current_player_name == @name1 && !(curr_pos==13)
      #   @cups[6] << @cups[start_pos].pop
      # elsif current_player_name == @name2 && !(curr_pos==6)
      #   @cups[13] << @cups[start_pos].pop
      # else
      #   @cups[curr_pos] << @cups[start_pos].pop
      # end

      if curr_pos == 6
        @cups[curr_pos] << @cups[start_pos].pop if current_player_name == @name1
      elsif curr_pos == 13
        @cups[curr_pos] << @cups[start_pos].pop if current_player_name == @name2
      else
        @cups[curr_pos] << @cups[start_pos].pop
      end
    end

    render
    next_turn(curr_pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns
    # :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].count == 1
      :switch
    else
      ending_cup_idx
    end
    # case ending_cup_idx
    # when ending_cup_idx == 6 || ending_cup_idx == 13
    #   return :prompt
    # when @cups[ending_cup_idx].count == 1
    #   :switch
    # else
    #   ending_cup_idx
    # end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups.take(6).all? {|cup| cup.empty?} ||
    @cups[7..13].all? {|cup| cup.empty? }
  end

  def winner
    player1_count = @cups[6].count
    player2_count = @cups[13].count

    if player1_count == player2_count
      :draw
    else
      player1_count > player2_count ? @name1 : @name2
    end
  end
end

class StartCupEmpty < StandardError
  def message
    "Starting cup is empty"
  end
end

class InvalidStartingCup < StandardError
  def message
    "Invalid starting cup"
  end
end
