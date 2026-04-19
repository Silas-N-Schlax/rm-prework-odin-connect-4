require_relative "../lib/connect_four"
describe Game do
  describe "#user_input" do
    let(:player1) { instance_double("Player", color: nil, name: "Bob") }
    subject(:game_input) { described_class.new(player1, nil, nil) }
    context "when user input is invalid then valid" do
      before do
        allow(game_input).to receive(:gets).and_return("s", "3")
      end
      it "returns message once" do
        message = "\e[0;35;49mBob please enter a valid number (1-7) -> \e[0m"
        expect(game_input).to receive(:print).with(message).once
        game_input.user_input
      end
      it "returns input 3 after loop" do
        expect(game_input).to receive(:print)
        expect(game_input.user_input).to be(2)
      end
    end
    context "when user input is valid first time" do
      before do
        allow(game_input).to receive(:gets).and_return("3")
      end
      it "returns input 3" do
        expect(game_input.user_input).to be(2)
      end
    end
  end

  describe "#update_turn" do
    let(:player1) { instance_double("Player", color: nil, name: "Bob") }
    let(:player2) { instance_double("Player", color: nil, name: "Steve") }
    subject(:game_turn) { described_class.new(player1, player2, nil) }
    context "when is player 1 turn" do
      it "switch to player 2 turn" do
        game_turn.update_turn
        expect(game_turn.instance_variable_get(:@player_turn)).to be(player2)
      end
    end
    context "when is player 2 turn" do
      it "switch to player 1 turn" do
        game_turn.update_turn
        game_turn.update_turn
        expect(game_turn.instance_variable_get(:@player_turn)).to be(player1)
      end
    end
  end
end
