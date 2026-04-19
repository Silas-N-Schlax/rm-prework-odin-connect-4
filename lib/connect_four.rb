require_relative "connect_four/board"
require_relative "connect_four/player"
require "colorize"
# Game class
class Game
  def initialize(
    player1 = Player.new("\e[31m◉\e[0m"),
    player2 = Player.new("\e[33m◉\e[0m"),
    board = Board.new
  )
    @player1 = player1
    @player2 = player2
    @board = board
    @player_turn = @player2
  end

  def play
    input = round
    end_game(input)
  end

  def round
    loop do
      update_turn
      print "#{@player_turn.name} please enter a valid number (1-7) -> ".magenta
      input = user_input
      @board.update_board(input, @player_turn.color)

      return input if @board.game_over?(input)
    end
  end

  def update_turn
    @player_turn = @player_turn == @player1 ? @player2 : @player1
  end

  def end_game(column)
    message = @board.winner?(column) ? "#{@player_turn.name} wins!" : "It's a tie!"
    puts message
  end

  def user_input
    loop do
      input = gets.chomp.chars.first.to_i - 1
      return input if (0...7).cover?(input) && !@board.full?(input)

      print "#{@player_turn.name} please enter a valid number (1-7) -> ".magenta
    end
  end
end
