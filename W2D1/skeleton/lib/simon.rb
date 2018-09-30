class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    # until @game_over
    #   take_turn
    #   system("clear")
    # end
    #
    # game_over_message
    # reset_game

    while !@game_over
      take_turn
      system("clear")
    end

    game_over_message
    reset_game
  end

  # def take_turn
  #   show_sequence
  #   require_sequence
  #
  #   while !@game_over
  #     round_success_message
  #     @sequence_length += 1
  #   end
  # end

  def take_turn
    show_sequence
    require_sequence

    if !@game_over
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    (0...@seq.length).each do |idx|
      color = @seq[idx]
      puts color
      system("clear")
    end
  end



  def require_sequence
    puts "Repeat... "
    (0...@seq.length).each do |idx|
      color = @seq[idx]
      user_choice = gets.chomp
      if color[0] != user_choice
        @game_over = true
        break
      end
    end
  end

  def add_random_color
    # sequence = sequence_length
    # sequence += 1
    @seq << COLORS.shuffle[0]
  end

  def round_success_message
    puts "Round was successful. Continue forward."
  end

  def game_over_message
    puts "Game over!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
