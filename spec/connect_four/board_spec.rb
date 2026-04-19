require_relative "../../lib/connect_four/board"

describe Board do
  describe "#update_board" do
    context "when given row that is not full" do
      subject(:board) { described_class.new }
      it "returns true" do
        expect(board.update_board(1, "x")).to be(true)
      end
      it "updates row" do
        board.update_board(1, "x")
        new_board = board.instance_variable_get(:@board)
        expect(new_board[1][0]).to eq("x")
      end
    end
    context "when given a row that is full" do
      subject(:full_board) { described_class.new(Array.new(7) { Array.new(6) }) }
      it "returns false" do
        expect(full_board.update_board(1, "x")).to be(false)
      end
      it "does not update row" do
        full_board.update_board(1, "x")
        new_board = full_board.instance_variable_get(:@board)
        expect(new_board[1].length).to be(6)
      end
    end
  end

  describe "#winner?" do
    context "when player places the winning peice vertical" do
      subject(:winning_game) { described_class.new([%w[x x x x], [], [], [], [], [], []]) }
      it "returns true" do
        expect(winning_game.winner?(0)).to be(true)
      end
    end
    context "when player places the winning peice horizontal" do
      subject(:winning_game) { described_class.new([["x"], ["x"], ["x"], ["x"], [], [], []]) }
      it "returns true" do
        expect(winning_game.winner?(0)).to be(true)
      end
    end
    context "when player places the winning peice diagonal" do
      subject(:winning_game) { described_class.new([["x"], [nil, "x"], [nil, nil, "x"], [nil, nil, nil, "x"], [], [], []]) }
      it "returns true" do
        expect(winning_game.winner?(0)).to be(true)
      end
    end
    context "when player places the winning peice anti-diagonal" do
      subject(:winning_game) { described_class.new([[nil, nil, nil, "x"], [nil, nil, "x"], [nil, "x"], ["x"], [], [], []]) }
      it "returns true" do
        expect(winning_game.winner?(0)).to be(true)
      end
    end
    context "when player does not place the winning peice" do
      subject(:going_game) { described_class.new([%w[x x x y], [], [], [], [], [], []]) }
      it "return false" do
        expect(going_game.winner?(0)).to be(false)
      end
    end
  end

  describe "#game_over?" do
    context "when player places winning peice and fills board" do
      subject(:winning_game) { described_class.new(Array.new(7) { Array.new(6, "x") }) }
      it "returns true" do
        expect(winning_game.game_over?(0)).to be(true)
      end
    end
    context "when player does not place a winning peice and fills the board" do
      array = [
        %w[x x x o o o],
        %w[o o o x x x],
        %w[x x x o o o],
        %w[o o o x x x],
        %w[x x x o o o],
        %w[o o o x x x],
        %w[x x x o o o]
      ]
      subject(:winning_game) { described_class.new(array) }
      it "returns nil" do
        expect(winning_game.game_over?(0)).to be(true)
      end
    end
  end
end
