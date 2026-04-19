# Board class
class Board
  def initialize(board = Array.new(7) { [] })
    @board = board
  end

  def update_board(column, peice)
    return false if full?(column)

    @board[column].push(peice)
    send_board
    true
  end

  def full?(column)
    true if @board[column].length >= 6
  end

  def full_board?
    full_columns = 0
    @board.length.times do |i|
      full_columns += 1 if full?(i)
    end
    return true if full_columns >= @board.length

    false
  end

  def game_over?(column)
    true if winner?(column) || full_board?
  end

  def winner?(column)
    directions = [[1, 0], [0, 1], [1, 1], [-1, 1]] # [column, row]
    directions.each do |dir|
      row = @board[column].length - 1
      result = check_direction(dir, column, row, @board[column][row])
      return true if result
    end
    false
  end

  def check_direction(dir, column, row, peice)
    test_case = [
      get_player_peices_in_direction(column, row, dir.map { |x| x * -1 }, peice, []),
      @board[column][row],
      get_player_peices_in_direction(column, row, dir, peice, [])
    ].join(" ").split(" ")
    true if test_case.length >= 4
  end

  def get_player_peices_in_direction(column, row, dir, peice, list)
    return list if @board[column + dir[0]].nil? || @board[column + dir[0]][row + dir[1]].nil? || row + dir[1] == -1

    space = @board[column + dir[0]][row + dir[1]]
    return list if space != peice

    list << space
    get_player_peices_in_direction(column + dir[0], row + dir[1], dir, peice, list)
  end

  def send_board
    board = generate_board
    board.each { |line| puts line }
  end

  def generate_board
    constant_board = ["╔═══╦═══╦═══╦═══╦═══╦═══╦═══╗", "  1   2   3   4   5   6   7", "╚═══╩═══╩═══╩═══╩═══╩═══╩═══╝"]
    middle_board = generate_middle_board
    constant_board.each { |const| middle_board.unshift("\e[36m#{const}\e[0m") }
    middle_board.rotate(1)
  end

  def generate_middle_board
    board = Array.new(6) { [] }
    @board.each_with_index do |column, i|
      6.times do |j|
        board[j].push(i.zero? ? "\e[36m║ #{column[j] || ' '} \e[36m║" : " #{column[j] || ' '} \e[36m║")
      end
    end
    board.each_with_index do |item, i|
      board[i] = item.join
    end
    board.reverse!
  end
end
